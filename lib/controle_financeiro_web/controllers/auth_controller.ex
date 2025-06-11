defmodule ControleFinanceiroWeb.AuthController do
  use ControleFinanceiroWeb, :controller
  alias ControleFinanceiro.Accounts
  alias ControleFinanceiro.Guardian

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, token, _claims} = Guardian.encode_and_sign(user)
        json(conn, %{token: token})

      {:error, reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: to_string(reason)})
    end
  end
end
