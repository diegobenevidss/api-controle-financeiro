# 📊 API de Controle Financeiro Pessoal

Este projeto é uma API REST desenvolvida em Elixir com o framework Phoenix. A aplicação permite gerenciar receitas, despesas e categorias financeiras de forma segura, com autenticação de usuários e controle relacional entre entidades.

---

## 🚀 Funcionalidades

- Cadastro, consulta, atualização e exclusão de **usuários**
- Cadastro, consulta, atualização e exclusão de **transações financeiras**
- Cadastro, consulta, atualização e exclusão de **categorias (tags)**
- Relacionamentos entre entidades:
  - `User` → `Transaction` (**1:N**)
  - `Transaction` ↔ `Tag` (**N:N**)
- Senhas protegidas com **Bcrypt**
- Estrutura preparada para **autenticação JWT**
- Banco de dados gerenciado via **Docker (PostgreSQL)**

---

## ⚙️ Tecnologias Utilizadas

- Elixir
- Phoenix Framework
- Ecto
- PostgreSQL (via Docker)
- Bcrypt Elixir

---

## 🧱 Estrutura das Entidades

### Usuário (`users`)
- `id`: Identificador (UUID)
- `name`: Nome do usuário
- `email`: E-mail (login)
- `password_hash`: Senha criptografada
- `inserted_at` e `updated_at`: Timestamps

Relacionamentos:
- `has_many :transactions`

---

### Transação (`transactions`)
- `id`: Identificador (UUID)
- `descricao`: Descrição da transação
- `valor`: Valor decimal
- `tipo`: Tipo da transação (`"RECEITA"` ou `"DESPESA"`)
- `data`: Data da transação
- `user_id`: Chave estrangeira do usuário
- `inserted_at` e `updated_at`: Timestamps

Relacionamentos:
- `belongs_to :user`
- `many_to_many :tags`

---

### Categoria (`tags`)
- `id`: Identificador (UUID)
- `nome`: Nome da categoria
- `user_id`: Chave estrangeira do usuário
- `inserted_at` e `updated_at`: Timestamps

Relacionamentos:
- `belongs_to :user`
- `many_to_many :transactions`

---

## 📦 Instalação e Execução

### Requisitos

- Elixir ≥ 1.14
- Docker e Docker Compose

### Passos

1. Clonar o repositório:

```bash
git clone https://github.com/diegobenevidss/api-controle-financeiro.git
cd controle-financeiro
```

2. Subir o banco de dados com Docker:

```bash
docker-compose up -d
```

3. Instalar as dependências:

```bash
mix deps.get
```

4. Criar e migrar o banco de dados:

```bash
mix ecto.create
mix ecto.migrate
```

5. Iniciar o servidor Phoenix:
```bash
mix phx.server
```
A aplicação estará disponível em: http://localhost:4000/api

---

## 📮 Endpoints da API

### Usuários - 
- `GET /api/users`
- `GET /api/users/:id`
- `POST /api/users`
- `PUT /api/users/:id`
- `DELETE /api/users/:id`

### Transações - 
- `GET /api/transactions`
- `GET /api/transactions/:id`
- `POST /api/transactions`
- `PUT /api/transactions/:id`
- `DELETE /api/transactions/:id`

### Categorias (Tags) - 
- `GET /api/tags`
- `GET /api/tags/:id`
- `POST /api/tags`
- `PUT /api/tags/:id`
- `DELETE /api/tags/:id`

## 🧑‍💻 Autores
Desenvolvido por **Diego Benevides**, **Ian Sampaio** e **Renan Elid**.