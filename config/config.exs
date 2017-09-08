# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :flight_reset_password, FlightResetPassword.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kJOUvXxBYCOQTLXHd64MqUgaAg6XPei+484gz7up41VJoqIRnkNjhuzqUXA8YD3K",
  render_errors: [view: FlightResetPassword.ErrorView, accepts: ~w(json)],
  pubsub: [name: FlightResetPassword.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
