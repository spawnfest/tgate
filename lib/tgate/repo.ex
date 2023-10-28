defmodule Tgate.Repo do
  use Ecto.Repo,
    otp_app: :tgate,
    adapter: Ecto.Adapters.Postgres

  @spec fetch_one(queryable :: Ecto.Queryable.t()) ::
          {:error, :not_found} | {:ok, Ecto.Schema.t()} | {:ok, term()}
  def fetch_one(queryable) do
    case one(queryable) do
      nil ->
        {:error, :not_found}

      entity ->
        {:ok, entity}
    end
  end
end
