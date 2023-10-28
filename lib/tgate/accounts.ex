defmodule Tgate.Accounts do
  @moduledoc """
  Context for registration/login stuff
  """

  alias Tgate.Accounts.Commands.RegisterUser

  def register_user(attrs) do
    RegisterUser.execute(attrs)
  end
end
