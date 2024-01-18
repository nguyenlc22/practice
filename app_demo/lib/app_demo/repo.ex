defmodule AppDemo.Repo do
  use Ecto.Repo,
  otp_app: :app_demo,
  adapter: Ecto.Adapters.Postgres
end
