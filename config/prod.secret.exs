use Mix.Config

config :bread_fixed, BreadFixed.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"}
