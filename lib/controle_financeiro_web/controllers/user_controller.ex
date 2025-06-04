defmodule ControleFinanceiroWeb.UserController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Accounts
  alias ControleFinanceiro.Accounts.User

  action_fallback ControleFinanceiroWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    json(conn, users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> json(user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    json(conn, user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      json(conn, user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
