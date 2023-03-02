defmodule NameCount.Repo do
  use Ecto.Repo,
    otp_app: :name_count,
    adapter: Ecto.Adapters.Postgres
end
