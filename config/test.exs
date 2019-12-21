use Mix.Config

# Configure your database
config :contact_us, ContactUs.Repo,
  username: "postgres",
  password: "postgres",
  database: "contact_us_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :contact_us, ContactUsWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
