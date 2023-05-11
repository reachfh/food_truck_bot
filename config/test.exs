import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :food_truck_bot, FoodTruckBot.Repo,
  username: System.get_env("DATABASE_USER") || "postgres",
  password: System.get_env("DATABASE_PASS") || "postgres",
  hostname: System.get_env("DATABASE_HOST") || "localhost",
  database:
    System.get_env("DATABASE_DB") || "food_truck_bot_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_truck_bot, FoodTruckBotWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "XRRPQb9X4qFVgdRC1P99tvW/W3Xp+h9XKInXATa2LOxjHITvDLE9hIN5ckE/dHrv",
  server: false

# In test we don't send emails.
config :food_truck_bot, FoodTruckBot.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger,
  level: :warn,
  metadata: [:file, :line]

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :junit_formatter,
  # report_file: "test-junit-report.xml",
  # report_dir: "/tmp",
  report_dir: "#{Mix.Project.build_path()}/junit-reports",
  # report_dir: "junit-reports",
  automatic_create_dir?: true,
  print_report_file: true,
  # prepend_project_name?: true,
  include_filename?: true,
  include_file_line?: true
