defmodule Tgate.Projects.Commands.RefreshAbonentCode do
  alias Tgate.Projects.Schemas.Abonent

  alias Tgate.Repo

  @secret Application.compile_env!(:tgate, :nimble_secret)

  @spec execute(abonent :: Abonent.t()) ::
          {:ok, Abonent.t()} | {:error, :code_not_expired} | {:error, Ecto.Changeset.t()}
  def execute(%Abonent{invite_code: code} = abonent) do
    with :ok <- validate_code_expired(code) do
      abonent
      |> Abonent.invite_changeset(%{invite_code: invite_code()})
      |> Repo.update()
    end
  end

  defp validate_code_expired(code) do
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
