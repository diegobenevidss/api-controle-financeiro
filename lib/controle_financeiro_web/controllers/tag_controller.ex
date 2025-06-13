defmodule ControleFinanceiroWeb.TagController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Finance
  alias ControleFinanceiro.Finance.Tag

  def index(conn, _params) do
    tags = Finance.list_tags()
    json(conn, tags)
  end

  def create(conn, %{"tag" => tag_params}) do
    case Finance.create_tag(tag_params) do
      {:ok, %Tag{} = tag} ->
        conn
        |> put_status(:created)
        |> json(tag)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Finance.get_tag!(id)
    json(conn, tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Finance.get_tag!(id)

    case Finance.update_tag(tag, tag_params) do
      {:ok, %Tag{} = tag} ->
        json(conn, tag)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Finance.get_tag!(id)

    case Finance.delete_tag(tag) do
      {:ok, _tag} ->
        send_resp(conn, :no_content, "")

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
    end
  end

  # Reutilizável para qualquer changeset
  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
