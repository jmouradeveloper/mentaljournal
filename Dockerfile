# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.3.0
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /rails

# Set development environment
ENV RAILS_ENV="development" \
    BUNDLE_PATH="/usr/local/bundle"


# Throw-away build stage to reduce size of final image
FROM base as build

# Install packages needed to build gems and Rails 8
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libvips pkg-config && \
    gem install rails -v "~> 8.0.0"

# Install application gems (will be created by Rails new)
COPY Gemfile* ./
RUN if [ -f "Gemfile" ]; then \
      bundle install && \
      rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
      bundle exec bootsnap precompile --gemfile; \
    fi

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times (if Rails app exists)
RUN if [ -f "bin/rails" ]; then bundle exec bootsnap precompile app/ lib/; fi

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY (if Rails app exists)
RUN if [ -f "bin/rails" ]; then SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile; fi


# Final stage for app image
FROM base

# Install packages needed for deployment and compilation
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips build-essential && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy built artifacts: gems, application
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Copy our custom entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Run and own only the runtime files as a non-root user for security
RUN useradd rails --create-home --shell /bin/bash && \
    mkdir -p db log storage tmp && \
    chown -R rails:rails /rails
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD []
