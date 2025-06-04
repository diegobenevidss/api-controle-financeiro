defmodule ControleFinanceiro.Finance.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :data, :naive_datetime
    field :descricao, :string
    field :valor, :decimal
    field :tipo, :string

    belongs_to :user, ControleFinanceiro.Accounts.User
    many_to_many :tags, ControleFinanceiro.Finance.Tag, join_through: "transactions_tags"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:descricao, :valor, :tipo, :data])
    |> validate_required([:descricao, :valor, :tipo, :data])
  end
end
