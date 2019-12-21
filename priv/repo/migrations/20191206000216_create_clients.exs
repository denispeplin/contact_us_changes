defmodule ContactUs.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients) do
      add :first_name, :string
      add :last_name, :string
      add :email_address, :string
      add :phone_number, :string
      add :company, :string
      add :service, :string

      timestamps()
    end

  end
end
