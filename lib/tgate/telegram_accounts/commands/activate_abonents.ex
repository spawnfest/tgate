defmodule Tgate.TelegramAccounts.Commands.ActivateAbonents do
  import Ecto.Query

  alias Tgate.TelegramAccounts.Schemas.Abonent

  alias Tgate.Repo

  @spec execute(telegram_id :: integer()) :: {non_neg_integer(), nil | [term()]}
  def execute(telegram_id) do
    Abonent
    |> by_telegram_id(telegram_id)
    |> Repo.update_all(set: [status: "active", updated_at: now()])
  end

  defp now do
    NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
  end

  defp by_telegram_id(query, telegram_id) do
    where(query, [a], a.status == ^"deactivated" and a.telegram_id == ^telegram_id)
  end
end
