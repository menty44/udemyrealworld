defmodule Udemyauth.Repo do
  use Ecto.Repo,
    otp_app: :udemyauth,
    adapter: Ecto.Adapters.Postgres
end
