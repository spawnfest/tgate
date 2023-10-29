defmodule Tgate.TelegramAccounts do
  @moduledoc """
  This context provides functionality to manipulate abonent account from
  within telegram bot. Also it provides abonent deactivation/reactivation for
  requests coming from web
  """

  alias Tgate.TelegramAccounts.Commands.ActivateAbonents
  alias Tgate.TelegramAccounts.Commands.ConfirmAbonent
  alias Tgate.TelegramAccounts.Commands.DeactivateAbonent
  alias Tgate.TelegramAccounts.Commands.DeactivateAbonents
  alias Tgate.TelegramAccounts.Commands.ReactivateAbonent

  def activate_abonents(telegram_id) do
    ActivateAbonents.execute(telegram_id)
  end

  def deactivate_abonents(telegram_id) do
    DeactivateAbonents.execute(telegram_id)
  end

  def confirm_abonent(telegram_id, code) do
    ConfirmAbonent.execute(telegram_id, code)
  end

  def deactivate_abonent(abonent_id) do
    DeactivateAbonent.execute(abonent_id)
  end

  def reactivate_abonent(abonent_id) do
    ReactivateAbonent.execute(abonent_id)
  end
end
