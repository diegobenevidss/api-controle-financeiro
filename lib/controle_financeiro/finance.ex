defmodule ControleFinanceiro.Finance do
  @moduledoc """
  The Finance context.
  """

  import Ecto.Query, warn: false
  alias ControleFinanceiro.Repo

  alias ControleFinanceiro.Finance.Transaction
  alias ControleFinanceiro.Finance.Tag

  # Transações

  @doc """
  Retorna todas as transações.
  """
  def list_transactions, do: Repo.all(Transaction)

  @doc """
  Busca uma transação por ID. Levanta erro se não encontrar.
  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Cria uma nova transação.
  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Atualiza uma transação existente.
  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Exclui uma transação.
  """
  def delete_transaction(%Transaction{} = transaction), do: Repo.delete(transaction)

  @doc """
  Retorna um changeset para a transação.
  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  # Tags

  @doc """
  Retorna todas as tags.
  """
  def list_tags, do: Repo.all(Tag)

  @doc """
  Busca uma tag por ID. Levanta erro se não encontrar.
  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Cria uma nova tag.
  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Atualiza uma tag existente.
  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Exclui uma tag.
  """
  def delete_tag(%Tag{} = tag), do: Repo.delete(tag)

  @doc """
  Retorna um changeset para a tag.
  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end
end
