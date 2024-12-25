import Config

config :ecto_example, EctoExample.Repo,
  database: "ecto_example_repo",
  username: "postgres"

config :ecto_example,
  ecto_repos: [EctoExample.Repo]
