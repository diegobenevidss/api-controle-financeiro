defmodule ControleFinanceiro.Finance.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Jason.Encoder, only: [:id, :description, :amount, :type, :date, :user_id]}
  schema "transactions" do
    field :description, :string
    field :amount, :decimal
    field :type, :string
    field :date, :utc_datetime
    belongs_to :user, ControleFinanceiro.Accounts.User, type: :binary_id

    timestamps()
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:description, :amount, :type, :date, :user_id])
    |> validate_required([:description, :amount, :type, :date, :user_id])
  end
end
