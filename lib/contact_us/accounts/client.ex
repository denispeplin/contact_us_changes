defmodule ContactUs.Accounts.Client do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clients" do
    field :company, :string
    field :email_address, :string
    field :first_name, :string
    field :last_name, :string
    field :phone_number, :string
    field :service, :string

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:first_name, :last_name, :email_address, :phone_number, :company, :service])
    |> validate_required([:first_name, :last_name, :email_address, :phone_number, :company, :service])
  end

  def validate_form_input(%Ecto.Changeset{changes: %{phone_number: number}} = changeset) do
    validate_phone_number(number)
    |> case do
        :error ->
          {:error, changeset
                  |> Map.put(:action, :insert)
                  |> add_error(:phone_number, "Number must be valid number")}

        _ -> {:ok, changeset}
      end
  end

  defp validate_phone_number(""), do: :ok

  defp validate_phone_number(value) do
    case Integer.parse(value) do
      {_integer, ""} -> :ok
      _ -> :error
    end
  end
end
