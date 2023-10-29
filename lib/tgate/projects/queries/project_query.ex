defmodule Tgate.Projects.Queries.ProjectQuery do
  import Ecto.Query

  alias Tgate.Projects.Schemas.Project

  alias Tgate.Repo

  @spec fetch(owner_id :: integer()) :: {:ok, Project.t()} | {:error, :not_found}
  def fetch(owner_id) do
    Project
    |> by_owner(owner_id)
    |> preload([:abonents])
    |> Repo.fetch_one()
  end

  defp by_owner(query, id) do
    where(query, [p], p.owner_id == ^id)
  end
end
