defmodule ControleFinanceiro.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ControleFinanceiro.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        inserted_at: ~N[2025-06-03 12:55:00],
        name: "some name",
        password_hash: "some password_hash",
        updated_at: ~N[2025-06-03 12:55:00]
      })
      |> ControleFinanceiro.Accounts.create_user()

    user
  end
end
