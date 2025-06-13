import Config

config :controle_financeiro, ControleFinanceiro.Repo,
  username: "postgres",
  password: "postgres",
  database: "controle_financeiro_dev",
  hostname: "localhost",
  port: 5432,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10


config :controle_financeiro, ControleFinanceiroWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base:
    "1719d04cbca940639bc559ce8a10a595598ce35d56e1013eaa2930f20bcb7d32b71c8a96a49b791fac2f2817c24e4c518bbe11bd11b8682efa77b505ef18fed2",
  watchers: []
