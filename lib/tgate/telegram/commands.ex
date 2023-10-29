defmodule Tgate.Telegram.Commands do
  @welcome_message """
  Welcome to Tgate BOT

  Here you can receive one time auth codes
  """
  def welcome(token, chat_id) do
    Telegram.Api.request(token, "sendMessage", chat_id: chat_id, text: @welcome_message)
  end

  def confirmation_success(token, chat_id) do
    Telegram.Api.request(token, "sendMessage", chat_id: chat_id, text: "Account confirmed")
  end

  def confirmation_fail(token, chat_id) do
    Telegram.Api.request(token, "sendMessage",
      chat_id: chat_id,
      text: "Failed to confirm account"
    )
  end
end
