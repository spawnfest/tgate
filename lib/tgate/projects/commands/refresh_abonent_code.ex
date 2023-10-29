defmodule Tgate.Projects.Commands.RefreshAbonentCode do
  import Ecto.Query

  alias Tgate.Projects.Schemas.Abonent

  alias Tgate.Repo

  @secret Application.compile_env!(:tgate, :nimble_secret)

  @spec execute(abonent_id :: integer()) ::
          {:ok, Abonent.t()} | {:error, :code_not_expired | Ecto.Changeset.t() | :not_found}
  def execute(abonent_id) do
    with {:ok, abonent} <- fetch_abonent(abonent_id),
         :ok <- validate_code_expired(abonent) do
      abonent
      |> Abonent.invite_changeset(%{invite_code: invite_code()})
      |> Repo.update()
    end
  end

  defp fetch_abonent(abonent_id) do
    Abonent
    |> by_id(abonent_id)
    |> Repo.fetch_one()
  end

  defp by_id(query, id) do
    where(query, [a], a.status == ^"pending" and a.id == ^id)
  end

  defp validate_code_expired(%Abonent{invite_code: code}) do
    if NimbleTOTP.valid?(@secret, code) do
      {:error, :code_not_expired}
    else
      :ok
    end
  end

  defp invite_code do
    NimbleTOTP.verification_code(@secret)
  end
end
