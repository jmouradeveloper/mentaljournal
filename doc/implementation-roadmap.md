# 🚀 Roadmap de Implementação - Mental Journal

## 📅 Cronograma Detalhado

### Fase 1: Fundação (Semana 1-2)
> **Objetivo**: Estabelecer base sólida com autenticação e estrutura

#### Semana 1: Setup e Autenticação
- [ ] **Setup do ambiente de desenvolvimento**
  - Configurar gems necessárias
  - Setup de testes (RSpec)
  - Configurar linting (RuboCop)

- [ ] **Sistema de Autenticação**
  - Migration e Model User
  - Migration e Model Session
  - SessionsController (login/logout)
  - UsersController (registro/perfil)
  - PasswordResetsController
  - ApplicationController helpers

- [ ] **Layouts e Componentes Base**
  - Layout principal da aplicação
  - Formulários de login/registro
  - Flash messages
  - Navigation básica

#### Semana 2: Entidades Core
- [ ] **Models e Migrations**
  - MoodCategory (migration + model + seeds)
  - Feeling (migration + model + seeds)
  - JournalEntry (migration + model)
  - EntryFeeling (migration + model)

- [ ] **Validações e Relacionamentos**
  - Validações completas nos models
  - Associações entre entidades
  - Scopes úteis
  - Testes unitários básicos

### Fase 2: Funcionalidades Core (Semana 3-5)
> **Objetivo**: Implementar funcionalidades principais do diário

#### Semana 3: Dashboard e Entrada Básica
- [ ] **Dashboard Principal**
  - Controller e views do dashboard
  - Entrada rápida do dia
  - Lista das últimas entradas
  - Estatísticas básicas

- [ ] **CRUD de Entradas**
  - JournalEntriesController completo
  - Formulário de criação/edição
  - Visualização de entrada individual
  - Validação de uma entrada por dia

#### Semana 4: Sistema de Sentimentos
- [ ] **Interface de Sentimentos**
  - Seleção visual de sentimentos
  - Níveis de intensidade
  - Categorização por cores
  - AJAX para melhor UX

- [ ] **Administração de Sentimentos**
  - CRUD para administrar sentimentos
  - Seeds com sentimentos padrão
  - Ativação/desativação de sentimentos

#### Semana 5: Visualizações e Análises
- [ ] **Gráficos Básicos**
  - Gráfico de humor ao longo do tempo
  - Distribuição de sentimentos
  - Gems: Chartkick + Chart.js

- [ ] **Histórico e Filtros**
  - Página de histórico completo
  - Filtros por data
  - Busca por conteúdo
  - Paginação

### Fase 3: Melhorias e Features Avançadas (Semana 6-8)
> **Objetivo**: Polir experiência e adicionar funcionalidades avançadas

#### Semana 6: Sistema de Objetivos
- [ ] **Goals (Objetivos)**
  - Migration e Model Goal
  - CRUD de objetivos
  - Status tracking
  - Notificações de prazo

- [ ] **Melhorias de UX**
  - Loading states
  - Confirmações de ações
  - Toasts/notificações
  - Responsividade mobile

#### Semana 7: Analytics Avançados
- [ ] **Relatórios Detalhados**
  - Relatório mensal/trimestral
  - Insights automáticos
  - Exportação de dados
  - Comparativos temporais

- [ ] **Features de Bem-estar**
  - Lembretes para escrever
  - Sugestões baseadas em padrões
  - Dicas de bem-estar

#### Semana 8: Polimento e Deploy
- [ ] **Testes e Qualidade**
  - Cobertura de testes completa
  - Testes de integração
  - Performance optimization
  - Security audit

- [ ] **Deploy e Produção**
  - Setup de produção
  - Backup strategy
  - Monitoring básico
  - Documentação de deploy

## 🛠️ Stack Tecnológico

### Backend
- **Ruby 3.3.0** - Linguagem principal
- **Rails 7.1.x** - Framework web
- **SQLite** - Banco de dados
- **BCrypt** - Hash de senhas
- **JWT** (opcional) - Para API futura

### Frontend
- **ERB Templates** - Views server-side
- **Stimulus** - JavaScript framework
- **Turbo** - SPA-like experience
- **Tailwind CSS** - Styling
- **Chart.js** - Gráficos
- **Alpine.js** (opcional) - Interatividade leve

### Gems Essenciais
```ruby
# Gemfile
gem 'rails', '~> 7.1.0'
gem 'sqlite3', '~> 1.4'
gem 'puma', '~> 6.0'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'sprockets-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'

# UI e Visualização
gem 'chartkick'
gem 'groupdate'
gem 'kaminari'           # Paginação
gem 'ransack'            # Busca avançada

# Utilitários
gem 'image_processing'   # Para uploads futuros
gem 'redis'              # Para cache (opcional)

group :development, :test do
  gem 'debug'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'web-console'
  gem 'letter_opener'     # Preview de emails
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'database_cleaner-active_record'
end
```

## 📋 Checklist de Features

### MVP (Minimum Viable Product)
- [ ] Registro e login de usuários
- [ ] Criação de entradas diárias
- [ ] Seleção de humor (1-10)
- [ ] Escolha de sentimentos com intensidade
- [ ] Visualização de histórico
- [ ] Gráfico básico de evolução
- [ ] Edição de perfil

### Features Avançadas
- [ ] Sistema de objetivos/metas
- [ ] Relatórios avançados
- [ ] Exportação de dados
- [ ] Notas do terapeuta (futuro)
- [ ] Lembretes e notificações
- [ ] Análises de padrões
- [ ] API REST (futuro)
- [ ] App mobile (futuro)

## 🧪 Estratégia de Testes

### Testes por Camada
```ruby
# Models (spec/models/)
- User authentication and validation
- JournalEntry validations and scopes
- Feeling and MoodCategory associations
- Session management

# Controllers (spec/controllers/)
- Authentication flows
- CRUD operations
- Access control
- Error handling

# System Tests (spec/system/)
- User registration and login
- Complete journal entry flow
- Dashboard interactions
- Mobile responsiveness

# Request Tests (spec/requests/)
- API endpoints (futuro)
- JSON responses
- Authentication headers
```

### Cobertura de Testes
- **Target**: 90%+ cobertura
- **Critical Paths**: 100% cobertura
- **Tools**: SimpleCov para métricas

## 🔒 Considerações de Segurança

### Autenticação
- [ ] Password strength validation
- [ ] Rate limiting para login
- [ ] Session timeout
- [ ] Secure cookie settings
- [ ] CSRF protection

### Dados Sensíveis
- [ ] Validação de input
- [ ] SQL injection prevention
- [ ] XSS protection
- [ ] Data encryption at rest (futuro)
- [ ] Audit logging

### Privacy
- [ ] LGPD compliance
- [ ] Data export capability
- [ ] Data deletion capability
- [ ] Privacy settings

## 📊 Métricas e Monitoramento

### KPIs do Produto
- Daily active users
- Entradas por usuário/mês
- Retention rate
- Time spent writing
- Feature adoption

### Performance Metrics
- Page load times
- Database query performance
- Error rates
- Uptime

### Tools
- **Development**: Rails logger, web-console
- **Production**: Sentry (errors), analytics básico

## 📚 Documentação

### Para Desenvolvedores
- [ ] Setup de desenvolvimento
- [ ] Guia de contribuição
- [ ] Documentação da API
- [ ] Troubleshooting guide

### Para Usuários
- [ ] Getting started guide
- [ ] FAQ
- [ ] Privacy policy
- [ ] Terms of service

## 🎯 Critérios de Sucesso

### Técnicos
- [ ] Aplicação roda sem erros
- [ ] Testes passando (>90% cobertura)
- [ ] Performance adequada (<2s load time)
- [ ] Mobile friendly
- [ ] Accessible (básico)

### Funcionais
- [ ] Usuário consegue registrar e fazer login
- [ ] Entrada diária funciona completamente
- [ ] Gráficos mostram dados corretos
- [ ] Histórico navega corretamente
- [ ] Dados persistem corretamente

### UX
- [ ] Interface intuitiva
- [ ] Feedback visual adequado
- [ ] Tratamento de erros amigável
- [ ] Loading states claros
- [ ] Mobile usable

Este roadmap fornece uma estrutura clara para implementação, priorizando funcionalidades essenciais e garantindo qualidade através de testes e boas práticas de desenvolvimento.
