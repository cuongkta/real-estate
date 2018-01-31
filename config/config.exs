# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :real_estate,
  ecto_repos: [RealEstate.Repo]

# Configures the endpoint
config :real_estate, RealEstateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3Vf+9hli/GLYLU0FBx4CJfMQ/wkwWzLC3Q0kwNFtg0MUtWUScsFaCNKgYoTFLAfU",
  render_errors: [view: RealEstateWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RealEstate.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Appsignal
config :appsignal, :config,
  active: false,
  enable_host_metrics: false,
  env: :dev
  
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
