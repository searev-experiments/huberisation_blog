use Mix.Config

# Configure your database
config :huberisation_blog, HuberisationBlog.Repo,
  username: "postgres",
  password: "postgres",
  database: "huberisation_blog_test",
  hostname: "localhost",
  port: "5433",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :huberisation_blog, HuberisationBlogWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :bcrypt_elixir, log_rounds: 4