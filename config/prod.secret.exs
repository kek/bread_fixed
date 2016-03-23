use Mix.Config

config :bread_fixed, Edt2.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"}
