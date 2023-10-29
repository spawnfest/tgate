defmodule Tgate.Telegram.Bot do
  use Telegram.Bot

  alias Tgate.TelegramAccounts

  alias Tgate.Telegram.Commands

  require Logger

  @impl Telegram.Bot
  def handle_update(%{"message" => %{"chat" => %{"id" => chat_id}, "text" => "/start"}}, token) do
    TelegramAccounts.activate_abonents(chat_id)

    Commands.welcome(token, chat_id)
  end

  @impl Telegram.Bot
  def handle_update(
        %{"message" => %{"chat" => %{"id" => chat_id}, "text" => "/confirm " <> code}},
        token
      ) do
    case TelegramAccounts.confirm_abonent(chat_id, code) do
      {:ok, _abonent} ->
        Commands.confirmation_success(token, chat_id)

      {:error, _error} ->
        Commands.confirmation_fail(token, chat_id)
    end
  end

  @impl Telegram.Bot
  def handle_update(
        %{
          "my_chat_member" => %{
            "chat" => %{"id" => chat_id},
            "new_chat_member" => %{"status" => "kicked"}
          }
        },
        _token
      ) do
    TelegramAccounts.deactivate_abonents(chat_id)

    :ok
  end

  @impl Telegram.Bot
  def handle_update(_update, _token) do
    Logger.debug("IGNORING UPDATE")
    :ok
  end
end
