# Meu RH - B2B SaaS de Gestão de Equipes

Meu RH é uma plataforma de Software as a Service (SaaS) voltada para o mercado B2B, focada na gestão ágil de funcionários, cargos e folha de pagamento. O sistema possui arquitetura multi-tenant, permitindo que múltiplas empresas utilizem a mesma infraestrutura de forma completamente isolada e segura.

## 🚀 Principais Funcionalidades

- **Multi-tenancy Nativo**: Isolamento completo de dados por empresa (`Company`) usando a gem `acts_as_tenant`.
- **Controle de Acesso Diferenciado**: Gestores (Admins) possuem controle total para criar cargos, relatórios e registrar funcionários, enquanto funcionários comuns acessam um painel restrito e seguro.
- **Bate-Ponto em Tempo Real**: Alteração de status (Em Serviço, Almoço, Folga, etc) sincronizada instantaneamente na tela de todos os colegas através de WebSockets (ActionCable + Hotwire Turbo Streams).
- **Chat da Empresa**: Comunicação interna em tempo real para toda a equipe, com identificação visual de Gestores.
- **Exportação de Relatórios**: Geração rápida de folhas de balanço em formato `.csv` detalhando salários, cargos e tempo de serviço.
- **Interface Premium**: Design System totalmente customizado focado na estética moderna do *Glassmorphism*, 100% responsivo e construído com Tailwind CSS.
- **Segurança de Dados**: Exclusão lógica (Soft Delete) através da gem `discard` para preservar o histórico da empresa e validações de CPF/CNPJ nativas.

## 🛠 Tecnologias Utilizadas

- **Ruby 3.4+**
- **Ruby on Rails 8.1**
- **PostgreSQL**
- **Hotwire** (Turbo & Stimulus)
- **Node.js + npm** (Gerenciamento de pacotes para o frontend)
- **Tailwind CSS & esbuild**
- Gems notáveis: `devise`, `acts_as_tenant`, `discard`, `cpf_cnpj`

## ⚙️ Configuração do Ambiente

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/arthun01/MeuRH.git
   cd MeuRH
   ```

2. **Instale as dependências:**
   ```bash
   bundle install
   npm install
   ```

3. **Crie e prepare o banco de dados PostgreSQL:**
   Certifique-se de que o Postgres está rodando e suas credenciais de desenvolvimento estão configuradas no seu ambiente.
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Inicie o servidor de desenvolvimento:**
   O projeto utiliza esbuild e Tailwind, portanto o servidor deve ser iniciado via `bin/dev` para compilar os assets em tempo real.
   ```bash
   ./bin/dev
   ```

5. **Acesso Local:**
   Abra o navegador em `http://localhost:3000`. Crie a sua primeira conta - você será automaticamente o Gestor da sua própria Empresa!

## 🤝 Fluxo de Trabalho (Testando as Funcionalidades)

1. Crie uma conta e cadastre a sua empresa.
2. Na barra lateral de **Gestão**, crie um **Cargo** definindo um Salário Base.
3. Cadastre novos **Funcionários** da sua equipe vinculados ao Cargo. (Opcional: adicione e-mail e senha de acesso para que o próprio funcionário acesse o sistema).
4. No menu lateral, acesse o **Chat Geral** e converse em tempo real.
5. Altere o status de algum funcionário e perceba as atualizações sendo refletidas automaticamente!

---
*Construído com Hotwire, Rails 8 e muito café.*
