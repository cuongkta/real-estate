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

config :canary,
  repo: RealEstate.Repo,
  current_user: :current_user,
  unauthorized_handler: {RealEstateWeb.SessionController, :handle_unauthorized},
  not_found_handler: {RealEstateWeb.SessionController, :handle_not_found}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"


config :real_estate, RealEstate.Auth.Guardian,
  issuer: "real_estate",
  ttl: { 3, :days },
  verify_issuer: true,
  secret_key: "lksdjowiurowieurlkjsdlwwer"

config :exq,
  name: Exq,
  host: "127.0.0.1",
  port: 6379,
  namespace: "exq",
  concurrency: :infinite,
  queues: ["subscribe"],
  poll_timeout: 50,
  scheduler_poll_timeout: 200,
  scheduler_enable: true,
  max_retries: 25,
  shutdown_timeout: 5000

config :exq_ui,
  web_port: 4040,
  web_namespace: "",
  server: true


config :real_estate, RealEstate.Scheduler,
  jobs: [
    # Every minute
    {"* * * * *",      {RealEstateWeb.CronJobController, :cron_work, ["daily report"]}},
    # # Every 15 minutes
    # {"*/15 * * * *",   fn -> System.cmd("rm", ["/tmp/tmp_"]) end},
    # # Runs on 18, 20, 22, 0, 2, 4, 6:
    # {"0 18-6/2 * * *", fn -> :mnesia.backup('/var/backup/mnesia') end},
    # # Runs every midnight:
    # {"@daily",         {Backup, :backup, []}}
  ]