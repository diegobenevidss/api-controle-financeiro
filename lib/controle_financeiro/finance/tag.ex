defmodule ControleFinanceiro.Finance.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name, :user_id, :inserted_at, :updated_at]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "tags" do
    field :name, :string
    belongs_to :user, ControleFinanceiro.Accounts.User, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
