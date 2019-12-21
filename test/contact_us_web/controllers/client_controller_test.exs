defmodule ContactUsWeb.ClientControllerTest do
  use ContactUsWeb.ConnCase

  alias ContactUs.Accounts

  @create_attrs %{company: "some company", email_address: "some email_address", first_name: "some first_name", last_name: "some last_name", phone_number: "some phone_number", service: "some service"}
  @update_attrs %{company: "some updated company", email_address: "some updated email_address", first_name: "some updated first_name", last_name: "some updated last_name", phone_number: "some updated phone_number", service: "some updated service"}
  @invalid_attrs %{company: nil, email_address: nil, first_name: nil, last_name: nil, phone_number: nil, service: nil}

  def fixture(:client) do
    {:ok, client} = Accounts.create_client(@create_attrs)
    client
  end

  describe "index" do
    test "lists all clients", %{conn: conn} do
      conn = get(conn, Routes.client_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Clients"
    end
  end

  describe "new client" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.client_path(conn, :new))
      assert html_response(conn, 200) =~ "New Client"
    end
  end

  describe "create client" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.client_path(conn, :create), client: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.client_path(conn, :show, id)

      conn = get(conn, Routes.client_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Client"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.client_path(conn, :create), client: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Client"
    end
  end

  describe "edit client" do
    setup [:create_client]

    test "renders form for editing chosen client", %{conn: conn, client: client} do
      conn = get(conn, Routes.client_path(conn, :edit, client))
      assert html_response(conn, 200) =~ "Edit Client"
    end
  end

  describe "update client" do
    setup [:create_client]

    test "redirects when data is valid", %{conn: conn, client: client} do
      conn = put(conn, Routes.client_path(conn, :update, client), client: @update_attrs)
      assert redirected_to(conn) == Routes.client_path(conn, :show, client)

      conn = get(conn, Routes.client_path(conn, :show, client))
      assert html_response(conn, 200) =~ "some updated company"
    end

    test "renders errors when data is invalid", %{conn: conn, client: client} do
      conn = put(conn, Routes.client_path(conn, :update, client), client: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Client"
    end
  end

  describe "delete client" do
    setup [:create_client]

    test "deletes chosen client", %{conn: conn, client: client} do
      conn = delete(conn, Routes.client_path(conn, :delete, client))
      assert redirected_to(conn) == Routes.client_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.client_path(conn, :show, client))
      end
    end
  end

  defp create_client(_) do
    client = fixture(:client)
    {:ok, client: client}
  end
end
