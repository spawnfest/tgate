defmodule Tgate.Accounts do
  @moduledoc """
  This module provides context interface for manipulating users in system
  """

  alias Tgate.Accounts.Commands.RegisterUser

  def register_user(attrs) do
    RegisterUser.execute(attrs)
  end
end
