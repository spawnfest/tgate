defmodule Tgate.Repo do
  use Ecto.Repo,
    otp_app: :tgate,
    adapter: Ecto.Adapters.Postgres
end
