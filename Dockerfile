# Use a imagem oficial do Ruby mais recente
FROM ruby:3.3.0

# Instalar dependências do sistema
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libsqlite3-dev \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Instalar Yarn
RUN npm install -g yarn

# Definir diretório de trabalho
WORKDIR /app

# Instalar Rails mais recente
RUN gem install rails -v 7.1.3

# Copiar script de entrada
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# Copiar Gemfile se existir
COPY Gemfile* ./

# Copiar código da aplicação
COPY . .

# Expor porta
EXPOSE 3000

# Script de entrada
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

# Comando padrão
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
