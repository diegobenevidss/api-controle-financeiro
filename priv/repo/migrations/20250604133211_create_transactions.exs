defmodule ControleFinanceiro.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :description, :string
      add :amount, :decimal
      add :type, :string
      add :date, :utc_datetime
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all)

      timestamps()
    end

    create index(:transactions, [:user_id])
  end
end
