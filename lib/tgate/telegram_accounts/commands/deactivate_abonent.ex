defmodule Tgate.TelegramAccounts.Commands.DeactivateAbonent do
  import Ecto.Query

  alias Tgate.TelegramAccounts.Schemas.Abonent

  alias Tgate.Repo

  @spec execute(abonent_id :: integer()) ::
          {:ok, Abonent.t()} | {:error, :not_found} | {:error, Ecto.Changeset.t()}
  def execute(abonent_id) do
    with {:ok, abonent} <- fetch_abonent(abonent_id) do
      abonent
      |> Abonent.deactivate_changeset(%{status: "deactivated"})
      |> Repo.update()
    end
  end

  defp fetch_abonent(id) do
    Abonent
    |> by_id(id)
    |> Repo.fetch_one()
  end

  defp by_id(query, id) do
    where(query, [a], a.status == ^"active" and a.id == ^id)
  end
end
