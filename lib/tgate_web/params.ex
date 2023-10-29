defmodule TgateWeb.Params do
  @moduledoc """
  Utility module for working with params
  """

  import Ecto.Changeset, only: [apply_action: 2]

  def change(module, attrs \\ %{}) do
    module
    |> struct()
    |> module.changeset(attrs)
  end

  def apply(module, attrs) do
    module
    |> struct()
    |> module.changeset(attrs)
    |> apply_action(:insert)
  end
end
