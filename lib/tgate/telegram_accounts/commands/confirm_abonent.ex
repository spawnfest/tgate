defmodule Tgate.TelegramAccounts.Commands.ConfirmAbonent do
  import Ecto.Query

  alias Tgate.TelegramAccounts.Schemas.Abonent

  alias Tgate.Repo

  @secret Application.compile_env!(:tgate, :nimble_secret)

  @spec execute(telegram_id :: integer(), code :: String.t()) ::
          {:ok, Abonent.t()} | {:error, :invalid_code} | {:error, :not_found}
  def execute(telegram_id, code) do
    with :ok <- validate_code(code),
         {:ok, abonent} <- fetch_abonent(code) do
      update_abonent(abonent, telegram_id)
    end
  end

  defp validate_code(code) do
    if NimbleTOTP.valid?(@secret, code) do
      :ok
    else
      {:error, :invalid_code}
    end
  end

  defp fetch_abonent(code) do
    Abonent
    |> by_code(code)
    |> Repo.fetch_one()
  end

  defp update_abonent(abonent, telegram_id) do
    abonent
    |> Abonent.confirm_changeset(%{
      telegram_id: telegram_id,
      status: "active",
      updated_at: now(),
      invite_code: nil
    })
    |> Repo.update()
  end

  defp now do
    NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
  end

  defp by_code(query, code) do
    where(query, [a], a.status == "pending" and a.invite_code == ^code)
  end
end
