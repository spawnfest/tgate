defmodule Tgate.Seeds do
  alias Tgate.Accounts
  alias Tgate.Projects

  def seed! do
    user = seed_user!()

    user
    |> seed_project!()
    |> seed_abonent!()

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
      |> Projects.create_project(%{name: "SpawnFest 2023"})

    project
  end

  defp seed_abonent!(project) do
    {:ok, abonent} = Projects.add_abonent(project, %{name: "Shinobu"})
    abonent
  end
end

Tgate.Seeds.seed!()
