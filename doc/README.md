# 📚 Documentação - Mental Journal

## 📁 Estrutura da Documentação

Este diretório contém toda a documentação técnica e de planejamento do projeto Mental Journal.

### 📄 Arquivos Disponíveis

1. **[technical-planning.md](./technical-planning.md)**
   - Planejamento técnico completo do sistema
   - Análise de requisitos e funcionalidades
   - Detalhamento das entidades e relacionamentos
   - Aspectos de segurança e autenticação
   - Considerações de performance e testes

2. **[entity-relationship-diagram.md](./entity-relationship-diagram.md)**
   - Diagrama de relacionamento entre entidades
   - Descrição detalhada dos relacionamentos
   - Índices e constraints recomendados
   - Queries comuns e otimizações
   - Estratégia de migrations

3. **[implementation-roadmap.md](./implementation-roadmap.md)**
   - Cronograma detalhado de implementação
   - Stack tecnológico e gems necessárias
   - Checklist de features MVP e avançadas
   - Estratégia de testes e cobertura
   - Critérios de sucesso e métricas

## 🎯 Sobre o Projeto

**Mental Journal** é uma aplicação Rails monolítica para diário de sentimentos terapêuticos, onde pacientes podem:

- 📝 **Registrar entradas diárias** com humor e sentimentos
- 📊 **Visualizar evolução** através de gráficos
- 🎯 **Definir objetivos** terapêuticos
- 🔒 **Manter privacidade** dos dados pessoais
- 📱 **Acessar de qualquer dispositivo**

## 🏗️ Arquitetura Resumida

### Entidades Principais
- **Users** - Pacientes do sistema
- **Journal_Entries** - Entradas diárias do diário
- **Feelings** - Sentimentos disponíveis
- **Entry_Feelings** - Relacionamento N:N com intensidades
- **Goals** - Objetivos terapêuticos
- **Sessions** - Controle de sessões (auth própria)

### Stack Tecnológico
- **Ruby 3.3.0** + **Rails 7.1.x**
- **SQLite** (desenvolvimento e produção)
- **BCrypt** (autenticação própria, sem Devise)
- **Stimulus + Turbo** (JavaScript moderno)
- **Chart.js** (visualização de dados)
- **Docker + Docker Compose** (containerização)

## 🚀 Como Usar Esta Documentação

### Para Desenvolvedores
1. Leia primeiro o **technical-planning.md** para entender o escopo
2. Consulte o **entity-relationship-diagram.md** para a estrutura de dados
3. Siga o **implementation-roadmap.md** para implementação

### Para Product Owners
1. Foque na seção "Análise de Requisitos" do technical-planning.md
2. Revise o cronograma no implementation-roadmap.md
3. Acompanhe o checklist de features

### Para Arquitetos
1. Analise o diagrama de entidades completo
2. Revise as considerações de segurança e performance
3. Valide a estratégia de testes e deploy

## 🔄 Versionamento

Esta documentação é versionada junto com o código e deve ser atualizada conforme as decisões de arquitetura evoluem.

### Changelog de Documentação
- **v1.0** (atual) - Planejamento inicial completo
- Futuras versões serão documentadas aqui

## 📞 Contato e Contribuição

Para sugestões ou correções na documentação:
1. Abra uma issue descrevendo a melhoria
2. Proponha mudanças via pull request
3. Mantenha a documentação sincronizada com o código

---

**Última atualização**: 2024-12-16  
**Versão da documentação**: 1.0  
**Status do projeto**: Planejamento Técnico Completo ✅
