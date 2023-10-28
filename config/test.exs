import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :tgate, Tgate.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "tgate_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tgate, TgateWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+s65abRzH6XAPT7kqmixAtrY9Ki8LKlpkKVa+SzlBGv4FWsAAdZ7Fh6boqYYOi+p",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :argon2_elixir,
  t_cost: 1,
  m_cost: 8
