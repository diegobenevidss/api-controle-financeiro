defmodule ControleFinanceiro.FinanceTest do
  use ControleFinanceiro.DataCase

  alias ControleFinanceiro.Finance

  describe "transactions" do
    alias ControleFinanceiro.Finance.Transaction

    import ControleFinanceiro.FinanceFixtures

    @invalid_attrs %{data: nil, descricao: nil, valor: nil, tipo: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Finance.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Finance.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{data: ~N[2025-06-03 13:32:00], descricao: "some descricao", valor: "120.5", tipo: "some tipo"}

      assert {:ok, %Transaction{} = transaction} = Finance.create_transaction(valid_attrs)
      assert transaction.data == ~N[2025-06-03 13:32:00]
      assert transaction.descricao == "some descricao"
      assert transaction.valor == Decimal.new("120.5")
      assert transaction.tipo == "some tipo"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{data: ~N[2025-06-04 13:32:00], descricao: "some updated descricao", valor: "456.7", tipo: "some updated tipo"}

      assert {:ok, %Transaction{} = transaction} = Finance.update_transaction(transaction, update_attrs)
      assert transaction.data == ~N[2025-06-04 13:32:00]
      assert transaction.descricao == "some updated descricao"
      assert transaction.valor == Decimal.new("456.7")
      assert transaction.tipo == "some updated tipo"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_transaction(transaction, @invalid_attrs)
      assert transaction == Finance.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Finance.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Finance.change_transaction(transaction)
    end
  end

  describe "tags" do
    alias ControleFinanceiro.Finance.Tag

    import ControleFinanceiro.FinanceFixtures

    @invalid_attrs %{nome: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Finance.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Finance.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{nome: "some nome"}

      assert {:ok, %Tag{} = tag} = Finance.create_tag(valid_attrs)
      assert tag.nome == "some nome"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      update_attrs = %{nome: "some updated nome"}

      assert {:ok, %Tag{} = tag} = Finance.update_tag(tag, update_attrs)
      assert tag.nome == "some updated nome"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_tag(tag, @invalid_attrs)
      assert tag == Finance.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Finance.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Finance.change_tag(tag)
    end
  end
end
