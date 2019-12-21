defmodule ContactUsWeb.ClientLive.Index do
  use Phoenix.LiveView

  alias ContactUsWeb.Router.Helpers, as: Routes
  alias ContactUsWeb.ClientView
  alias ContactUs.Accounts
  alias ContactUs.Accounts.Client

  def mount(_session, socket) do
    IO.inspect(connected?(socket), label: "CONNTECTION STATUS")
    value = %{
      changeset: Accounts.change_client(%Client{}),
      form_data: %{                # This is the form data to be captured and utilized to create a new client
        "first_name" => "",
        "last_name" => "",
        "email_address" => "",
        "phone_number" => "",
        "company" => "",
        "service" => "",
      }
    }
    {:ok, assign(socket, value)}
  end

  def render(assigns) do
    ClientView.render("form.html", assigns)
  end

  def handle_event("validate", %{"client" => params}, socket) do
    changeset =
      %Client{}
      |> Accounts.change_client(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset, form_data: params)}
  end

  def handle_event("save", %{"client" => params} = args, socket) do
    params
    |> Accounts.create_client()
    |> case do
        {:ok, _user} ->
          {:stop,
          socket
          |> put_flash(:info, "Client created")
          |> redirect(to: Routes.client_path(ContactUsWeb.Endpoint, :index))}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
