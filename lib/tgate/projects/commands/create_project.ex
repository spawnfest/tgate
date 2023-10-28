defmodule Tgate.Projects.Commands.CreateProject do
  alias Tgate.Projects.Schemas.Owner
  alias Tgate.Projects.Schemas.Project

  alias Tgate.Repo

  @type attrs :: %{
          name: String.t()
        }

  @spec execute(owner :: Owner.t(), attrs :: attrs()) ::
          {:ok, Project.t()} | {:error, Ecto.Changeset.t()}
  def execute(%Owner{id: owner_id}, attrs) do
    attrs
    |> Map.put(:owner_id, owner_id)
    |> insert_project()
  end

  defp insert_project(attrs) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end
end
