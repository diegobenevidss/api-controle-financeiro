defmodule ControleFinanceiroWeb.TransactionController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Finance
  alias ControleFinanceiro.Finance.Transaction

  def index(conn, _params) do
    transactions = Finance.list_transactions()
    json(conn, transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    case Finance.create_transaction(transaction_params) do
      {:ok, %Transaction{} = transaction} ->
        conn
        |> put_status(:created)
        |> json(transaction)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Finance.get_transaction!(id)
    json(conn, transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Finance.get_transaction!(id)

    case Finance.update_transaction(transaction, transaction_params) do
      {:ok, %Transaction{} = transaction} ->
        json(conn, transaction)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset_errors(changeset)})
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Finance.get_transaction!(id)

    case Finance.delete_transaction(transaction) do
      {:ok, _} ->
        send_resp(conn, :no_content, "")

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
    end
  end

  # Função auxiliar para retornar erros formatados sem precisar de view
  defp changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
