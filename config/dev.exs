import Config

config :controle_financeiro, ControleFinanceiro.Repo,
  username: "postgres",
  password: "postgres",
  database: "controle_financeiro_dev",
  hostname: "localhost",
  port: 5432,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
