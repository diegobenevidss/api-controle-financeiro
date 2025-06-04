defmodule ControleFinanceiroWeb.FallbackController do
  use ControleFinanceiroWeb, :controller

  # Tratamento para erros com Changeset (validação de dados)
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ControleFinanceiroWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # Tratamento para erros genéricos como not_found
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ControleFinanceiroWeb.ErrorView)
    |> render("404.json")
  end
end
