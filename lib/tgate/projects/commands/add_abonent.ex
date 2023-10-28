defmodule Tgate.Projects.Commands.AddAbonent do
  alias Tgate.Projects.Schemas.Project
  alias Tgate.Projects.Schemas.Abonent

  alias Tgate.Repo

  @type attrs :: %{
          name: String.t()
        }

  @secret Application.compile_env!(:tgate, :nimble_secret)

  @five_minutes_in_seconds 5 * 60

  @spec execute(project :: Project.t(), attrs :: attrs()) ::
          {:ok, Abonent.t()} | {:error, Ecto.Changeset.t()}
  def execute(%Project{id: project_id}, attrs) do
    attrs
    |> Map.merge(%{project_id: project_id, invite_code: invite_code()})
    |> insert_abonent()
  end

  defp invite_code do
    NimbleTOTP.verification_code(@secret, period: @five_minutes_in_seconds)
  end

  defp insert_abonent(attrs) do
    %Abonent{}
    |> Abonent.invite_changeset(attrs)
    |> Repo.insert()
  end
end
