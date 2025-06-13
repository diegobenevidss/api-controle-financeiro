defmodule ControleFinanceiroWeb.UserController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Accounts
  alias ControleFinanceiro.Accounts.User

  def index(conn, _params) do
    users =
      Accounts.list_users()
      |> Enum.map(fn user ->
        %{
          id: user.id,
          name: user.name,
          email: user.email
        }
      end)

    json(conn, users)
  end

  def create(conn, user_params) do
    case Accounts.create_user(user_params) do
      {:ok, %User{} = user} ->
        conn
        |> put_status(:created)
        |> json(%{
          id: user.id,
          name: user.name,
          email: user.email
        })

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    json(conn, %{
      id: user.id,
      name: user.name,
      email: user.email
    })
  end

  def update(conn, %{"id" => id} = params) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, Map.delete(params, "id")) do
      {:ok, %User{} = user} ->
        json(conn, %{
          id: user.id,
          name: user.name,
          email: user.email
        })

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    case Accounts.delete_user(user) do
      {:ok, %User{}} ->
        send_resp(conn, :no_content, "")

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
