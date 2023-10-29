defmodule Tgate.Seeds do
  alias Tgate.Accounts
  alias Tgate.Projects

  def seed! do
    user = seed_user!()

    seed_project!(user)
    :ok
  end

  defp seed_user! do
    {:ok, user} = Accounts.register_user(%{email: "test@gmail.com", password: "123456"})
    user
  end

  defp seed_project!(user) do
    {:ok, project} =
      user
      |> Projects.exchange_for_owner()
      |> Projects.create_project(%{name: "SpawnFest 2023 Project"})

    project
  end
end

Tgate.Seeds.seed!()
