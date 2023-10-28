defmodule Tgate.Projects.Commands.ConfirmAbonent do
  import Ecto.Query

  alias Tgate.Projects.Schemas.Abonent

  alias Tgate.Repo

  @secret Application.compile_env!(:tgate, :nimble_secret)

  def execute(code, telegram_id) do
    with :ok <- validate_code(code),
         {:ok, abonent} <- fetch_abonent(code) do
      update_abonent(abonent, telegram_id)
    end
  end

  defp validate_code(code) do
    if NimbleTOTP.valid?(@secret, code) do
      :ok
    else
      {:error, :code_not_valid}
    end
  end

  defp fetch_abonent(code) do
    Abonent
    |> by_code(code)
    |> Repo.fetch_one()
  end

  defp update_abonent(abonent, telegram_id) do
    abonent
    |> Abonent.confirm_changeset(%{telegram_id: telegram_id, status: "active", invite_code: nil})
    |> Repo.update()
  end

  defp by_code(query, code) do
    where(query, [a], a.status == ^"pending" and a.code == ^code)
  end
end
