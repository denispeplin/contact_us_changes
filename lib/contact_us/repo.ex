defmodule ContactUs.Repo do
  use Ecto.Repo,
    otp_app: :contact_us,
    adapter: Ecto.Adapters.Postgres
end
