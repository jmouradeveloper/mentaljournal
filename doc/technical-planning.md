# 📋 Planejamento Técnico - Mental Journal

## 🎯 Análise de Requisitos

### Funcionalidades Principais:
1. **Autenticação de Pacientes** - Login/logout seguro (implementação própria)
2. **Diário Diário** - Entrada de sentimentos e evolução
3. **Categorização de Sentimentos** - Organização por tipos/intensidade
4. **Histórico e Análises** - Visualização da evolução temporal
5. **Privacidade e Segurança** - Dados sensíveis protegidos

## 🏗️ Arquitetura de Entidades

### Diagrama de Relacionamentos
Ver arquivo: `entity-relationship-diagram.md`

## 📊 Detalhamento das Entidades

### 1. **Users (Pacientes)**
```ruby
# Principais campos:
- email (único, obrigatório)
- password_digest (bcrypt - implementação própria)
- first_name, last_name
- birth_date (para análises etárias)
- phone (contato de emergência)
- bio (apresentação pessoal)
- active (soft delete)
- remember_token (para sessões persistentes)
- password_reset_token (para recuperação de senha)
- password_reset_sent_at
```

### 2. **Journal_Entries (Entradas do Diário)**
```ruby
# Principais campos:
- user_id (FK para Users)
- entry_date (data da entrada - única por usuário/dia)
- mood_level (escala 1-10 do humor geral)
- content (texto livre do diário)
- privacy_level (0: privado, 1: compartilhado com terapeuta)
- is_draft (permite salvar rascunhos)
```

### 3. **Feelings (Sentimentos)**
```ruby
# Sentimentos pré-cadastrados:
- name (ex: "Ansioso", "Feliz", "Triste")
- color_hex (cor para visualização)
- icon (ícone FontAwesome ou similar)
- category_id (FK para mood_categories)
- active (permite desativar sentimentos)
```

### 4. **Entry_Feelings (Relacionamento N:N)**
```ruby
# Liga entradas do diário com sentimentos:
- journal_entry_id (FK)
- feeling_id (FK)
- intensity_level (1-5: intensidade do sentimento)
- notes (observações específicas sobre o sentimento)
```

### 5. **Mood_Categories (Categorias de Humor)**
```ruby
# Categorias como: Positivo, Negativo, Neutro, Ansiedade, etc.
- name, description
- color_hex (para consistência visual)
- sort_order (ordenação na interface)
- active
```

### 6. **Therapist_Notes (Notas do Terapeuta)**
```ruby
# Para futuras funcionalidades de acompanhamento:
- user_id (paciente)
- journal_entry_id (entrada específica comentada)
- content (nota do terapeuta)
- visible_to_patient (controle de visibilidade)
```

### 7. **Goals (Objetivos Terapêuticos)**
```ruby
# Metas e objetivos do paciente:
- user_id
- title, description
- target_date (prazo para alcançar)
- status (pending, in_progress, completed, cancelled)
```

### 8. **Sessions (Controle de Sessões)**
```ruby
# Para gerenciar sessões de usuário:
- user_id (FK para Users)
- session_token (token único da sessão)
- ip_address (endereço IP)
- user_agent (navegador/dispositivo)
- expires_at (expiração da sessão)
- active (status da sessão)
```

## 🔒 Aspectos de Segurança

### Autenticação Própria:
- **BCrypt** para hash de senhas
- **Secure tokens** para sessões
- **Password strength** validação
- **Rate limiting** para tentativas de login
- **Session timeout** para inatividade
- **Remember me** funcionalidade segura

### Autorização:
- **Controller filters** para verificação de autenticação
- **Method-based authorization** nos models
- **Strong Parameters** para proteção contra mass assignment
- **CSRF protection** ativada

### Privacidade de Dados:
- Criptografia de dados sensíveis
- Logs de auditoria para acessos
- Backup seguro do banco SQLite
- Política de retenção de dados
- **HTTPS** obrigatório em produção

## 📱 Interface e UX

### Dashboard Principal:
- **Entrada rápida do dia** - formulário simplificado
- **Gráfico de humor** - últimos 30 dias
- **Sentimentos frequentes** - tags visuais
- **Metas em progresso** - status dos objetivos

### Formulário de Entrada:
- **Data selecionável** (padrão hoje)
- **Escala visual de humor** (1-10 com emojis)
- **Seleção de sentimentos** (chips coloridos)
- **Editor de texto** para narrativa livre
- **Níveis de intensidade** por sentimento

### Sistema de Autenticação:
- **Login/Logout** simples e intuitivo
- **Recuperação de senha** via email
- **Lembrar-me** para conveniência
- **Perfil do usuário** editável

## 🚀 Implementação da Autenticação

### Models necessários:
```ruby
# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  
  # Validações
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, :last_name, presence: true
  validates :password, length: { minimum: 8 }, confirmation: true, if: :password_required?
  
  # Métodos de autenticação
  def self.authenticate(email, password)
  def generate_password_reset_token!
  def password_reset_expired?
  def remember_me!
  def forget_me!
end

# app/models/session.rb
class Session < ApplicationRecord
  belongs_to :user
  
  validates :session_token, presence: true, uniqueness: true
  validates :user_id, presence: true
  
  scope :active, -> { where(active: true) }
  scope :expired, -> { where('expires_at < ?', Time.current) }
  
  def self.cleanup_expired
  def expired?
  def extend_expiration!
end
```

### Controllers necessários:
- **SessionsController** - login/logout
- **UsersController** - registro/perfil
- **PasswordResetsController** - recuperação de senha
- **ApplicationController** - helpers de autenticação

## 🔧 Próximos Passos de Implementação

### Fase 1 - Estrutura Base (1-2 semanas)
1. **Setup de Autenticação própria** (bcrypt)
2. **Migrations das entidades principais**
3. **Models com validações básicas**
4. **Seeds para sentimentos e categorias**
5. **Sistema de sessões seguro**

### Fase 2 - Funcionalidades Core (2-3 semanas)
1. **Dashboard principal**
2. **CRUD de entradas do diário**
3. **Sistema de sentimentos e intensidades**
4. **Gráficos básicos de evolução**

### Fase 3 - Melhorias e Analytics (1-2 semanas)
1. **Relatórios avançados**
2. **Exportação de dados**
3. **Sistema de objetivos**
4. **Melhorias de UX/UI**

## 📋 Considerações Técnicas

### Performance:
- **Índices** nas FKs e campos de busca frequente
- **Paginação** para listas grandes
- **Cache** para dados estatísticos
- **Lazy loading** para relacionamentos

### Validações Importantes:
- Uma entrada por usuário por dia
- Intensidade de sentimentos entre 1-5
- Mood level entre 1-10
- Email único e válido
- Senha forte obrigatória
- Campos obrigatórios consistentes

### Testes:
- **Unit tests** para models
- **Integration tests** para controllers
- **System tests** para fluxos principais
- **Factory Bot** para dados de teste
- **Testes de segurança** para autenticação

### Gems Recomendadas:
```ruby
# Gemfile
gem 'bcrypt', '~> 3.1.7'           # Para hash de senhas
gem 'image_processing', '~> 1.2'   # Para avatars (futuro)
gem 'chartkick'                     # Para gráficos
gem 'groupdate'                     # Para agrupamento de dados por data
gem 'kaminari'                      # Para paginação
gem 'ransack'                       # Para busca avançada
gem 'bootsnap', require: false     # Para performance

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'letter_opener'               # Para preview de emails
end
```

## 🎨 Design System

### Cores Principais:
- **Primary**: #4F46E5 (Índigo) - Para ações principais
- **Success**: #10B981 (Verde) - Para sentimentos positivos
- **Warning**: #F59E0B (Âmbar) - Para sentimentos neutros
- **Danger**: #EF4444 (Vermelho) - Para sentimentos negativos
- **Info**: #3B82F6 (Azul) - Para informações

### Tipografia:
- **Headings**: Inter ou similar (clean, modern)
- **Body**: System fonts para melhor performance
- **Monospace**: Para dados técnicos

### Componentes UI:
- **Cards** para entradas do diário
- **Chips** para sentimentos
- **Progress bars** para objetivos
- **Charts** para visualização de dados
- **Forms** consistentes e acessíveis

Este planejamento fornece uma base sólida para implementar o sistema de diário terapêutico sem dependências externas pesadas, priorizando segurança, simplicidade e experiência do usuário.
