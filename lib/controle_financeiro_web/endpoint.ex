defmodule ControleFinanceiroWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :controle_financeiro

  # Serve arquivos estáticos
  plug Plug.Static,
    at: "/",
    from: :controle_financeiro,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt)

  # Código padrão do Phoenix
  if code_reloading? do
    plug Phoenix.CodeReloader
  end

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head

  plug CORSPlug,
    origin: "*",
    methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"]

  plug Plug.Session,
    store: :cookie,
    key: "_controle_financeiro_key",
    signing_salt: "algum_salt"

  plug ControleFinanceiroWeb.Router
end
