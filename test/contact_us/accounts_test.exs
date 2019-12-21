defmodule ContactUs.AccountsTest do
  use ContactUs.DataCase

  alias ContactUs.Accounts

  describe "clients" do
    alias ContactUs.Accounts.Client

    @valid_attrs %{company: "some company", email_address: "some email_address", first_name: "some first_name", last_name: "some last_name", phone_number: "some phone_number", service: "some service"}
    @update_attrs %{company: "some updated company", email_address: "some updated email_address", first_name: "some updated first_name", last_name: "some updated last_name", phone_number: "some updated phone_number", service: "some updated service"}
    @invalid_attrs %{company: nil, email_address: nil, first_name: nil, last_name: nil, phone_number: nil, service: nil}

    def client_fixture(attrs \\ %{}) do
      {:ok, client} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_client()

      client
    end

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Accounts.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Accounts.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      assert {:ok, %Client{} = client} = Accounts.create_client(@valid_attrs)
      assert client.company == "some company"
      assert client.email_address == "some email_address"
      assert client.first_name == "some first_name"
      assert client.last_name == "some last_name"
      assert client.phone_number == "some phone_number"
      assert client.service == "some service"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      assert {:ok, %Client{} = client} = Accounts.update_client(client, @update_attrs)
      assert client.company == "some updated company"
      assert client.email_address == "some updated email_address"
      assert client.first_name == "some updated first_name"
      assert client.last_name == "some updated last_name"
      assert client.phone_number == "some updated phone_number"
      assert client.service == "some updated service"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_client(client, @invalid_attrs)
      assert client == Accounts.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Accounts.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Accounts.change_client(client)
    end
  end
end
