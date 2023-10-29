defmodule Tgate.TelegramAccounts do
  alias Tgate.TelegramAccounts.Commands.ConfirmAbonent
  alias Tgate.TelegramAccounts.Commands.DeactivateAbonents
  alias Tgate.TelegramAccounts.Commands.ActivateAbonents

  def confirm_abonent(telegram_id, code) do
    ConfirmAbonent.execute(telegram_id, code)
  end

  def deactivate_abonents(telegram_id) do
    DeactivateAbonents.execute(telegram_id)
  end

  def activate_abonents(telegram_id) do
    ActivateAbonents.execute(telegram_id)
  end
end
