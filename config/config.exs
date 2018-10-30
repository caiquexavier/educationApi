# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :educationApi,
  ecto_repos: [EducationApi.Repo]

# Configures the endpoint
config :educationApi, EducationApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "u9BsUlPIiVkAtj76d3e3rw/m9Gs3hgBhEV44+g6vwHfK406EgycPt05UXNnretbf",
  render_errors: [view: EducationApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EducationApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

  config :educationApi, educationApiAuth: [
    username: "educationApi",
    password: "educationApiPwd",
    realm: "API"
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
