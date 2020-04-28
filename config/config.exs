# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cookpod,
  ecto_repos: [Cookpod.Repo]

# Configures the endpoint
config :cookpod, CookpodWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uwaigbrqkH8YRPYh9JqOLQFy0l0AAiXeVPOmrUHXfwwrEQFTwHY/ciU16dJU7iAq",
  render_errors: [view: CookpodWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Cookpod.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "Ki00G4KS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :template_engines,
	slim: PhoenixSlime.Engine,
	slime: PhoenixSlime.Engine,
	slimleex: PhoenixSlime.LiveViewEngine

config :cookpod, basic_auth: [
  username: "admin",
  password: "pass",
  realm: "Closed Area"
]  

config :cookpod, CookpodWeb.Gettext, locales: ~w(en ru), default_locale: "ru"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :arc,
  storage: Arc.Storage.Local
#   bucket: "cookpod"

# config :ex_aws, :s3,
#   access_key_id: "minio",
#   secret_access_key: "minio111",
#   region: "local",
#   bucket: "cookpod",
#   scheme: "http://", 
#   port: 9000,
#   host: "localhost"

config :cookpod, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: CookpodWeb.Router,     # phoenix routes will be converted to swagger paths
      endpoint: CookpodWeb.Endpoint  # (optional) endpoint config used to set host, port and https schemes.
    ]
  }

config :phoenix_swagger, json_library: Jason
