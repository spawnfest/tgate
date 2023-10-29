defmodule Tgate.Projects.Commands.AddAbonent do
  alias Tgate.Projects.Schemas.Project
  alias Tgate.Projects.Schemas.Abonent

  alias Tgate.Repo

  @type attrs :: %{
          name: String.t()
        }

  @secret Application.compile_env!(:tgate, :nimble_secret)

  @spec execute(project :: Project.t(), attrs :: attrs()) ::
          {:ok, Abonent.t()} | {:error, Ecto.Changeset.t()}
  def execute(%Project{id: project_id}, attrs) do
    attrs
    |> Map.merge(%{project_id: project_id, invite_code: invite_code()})
    |> insert_abonent()
  end

  defp invite_code do
    NimbleTOTP.verification_code(@secret)
  end

  defp insert_abonent(attrs) do
    %Abonent{}
    |> Abonent.invite_changeset(attrs)
    |> Repo.insert()
  end
end
