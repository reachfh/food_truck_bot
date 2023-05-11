import Config

config :food_truck_bot,
  data_sf_url: "https://data.sfgov.org"

config :food_truck_bot,
  ecto_repos: [FoodTruckBot.Repo]

# Configures the endpoint
config :food_truck_bot, FoodTruckBotWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: FoodTruckBotWeb.ErrorHTML, json: FoodTruckBotWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: FoodTruckBot.PubSub,
  live_view: [signing_salt: "yds6NGie"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :food_truck_bot, FoodTruckBot.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :logger,
  level: :info,
  utc_log: true

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :trace_id, :span_id]

if System.get_env("RELEASE_MODE") do
  config :kernel, :logger, [
    {:handler, :default, :logger_std_h,
     %{
       formatter:
         {:logger_formatter_json,
          %{
            names: :datadog
            # template: [
            #   :msg,
            #   :time,
            #   :level,
            #   :file,
            #   :line,
            #   :mfa,
            #   :pid,
            #   :trace_id,
            #   :span_id
            # ]
          }}
     }}
  ]
end

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

import_config "#{config_env()}.exs"
