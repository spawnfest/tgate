defmodule Tgate.TelegramAccounts.Commands.ReactivateAbonent do
  import Ecto.Query

  alias Tgate.TelegramAccounts.Schemas.Abonent
  alias Tgate.Repo

  @secret Application.compile_env!(:tgate, :nimble_secret)

  @spec execute(abonent_id :: integer()) ::
          {:ok, Abonent.t()} | {:error, Ecto.Changeset.t()} | {:error, :not_found}
  def execute(abonent_id) do
    with {:ok, abonent} <- fetch_abonent(abonent_id) do
      abonent
      |> Abonent.reactivate_changeset(%{invite_code: invite_code(), status: "pending"})
      |> Repo.update()
    end
  end

  defp invite_code do
    NimbleTOTP.verification_code(@secret)
  end

  defp fetch_abonent(id) do
    Abonent
    |> by_id(id)
    |> Repo.fetch_one()
  end

  defp by_id(query, id) do
    where(query, [a], a.status == ^"deactivated" and a.id == ^id)
  end
end
