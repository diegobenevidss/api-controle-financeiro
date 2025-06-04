defmodule ControleFinanceiroWeb.TagController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Finance
  alias ControleFinanceiro.Finance.Tag

  action_fallback ControleFinanceiroWeb.FallbackController

  def index(conn, _params) do
    tags = Finance.list_tags()
    json(conn, tags)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Finance.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> json(tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Finance.get_tag!(id)
    json(conn, tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Finance.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Finance.update_tag(tag, tag_params) do
      json(conn, tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Finance.get_tag!(id)

    with {:ok, %Tag{}} <- Finance.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
