defmodule ContactUsWeb.ClientLive.Index do
  use Phoenix.LiveView

  alias ContactUsWeb.Router.Helpers, as: Routes
  alias ContactUsWeb.ClientView
  alias ContactUs.Accounts
  alias ContactUs.Accounts.Client

  def mount(_session, socket) do
    IO.inspect(connected?(socket), label: "CONNTECTION STATUS")

    changeset = %Client{} |> Accounts.change_client() |> Map.put(:action, :insert)

    {:ok, assign(socket, changeset: changeset)}
  end

  def render(assigns) do
    ClientView.render("form.html", assigns)
  end

  def handle_event("validate", %{"client" => params}, socket) do
    changeset =
      %Client{}
      |> Accounts.change_client(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
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
