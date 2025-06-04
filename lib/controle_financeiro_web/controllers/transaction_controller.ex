defmodule ControleFinanceiroWeb.TransactionController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Finance
  alias ControleFinanceiro.Finance.Transaction

  action_fallback ControleFinanceiroWeb.FallbackController

  def index(conn, _params) do
    transactions = Finance.list_transactions()

    json(conn, transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Finance.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> json(transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Finance.get_transaction!(id)
    json(conn, transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Finance.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Finance.update_transaction(transaction, transaction_params) do
      json(conn, transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Finance.get_transaction!(id)

    with {:ok, %Transaction{}} <- Finance.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
