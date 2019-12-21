defmodule ContactUsWeb.Router do
  use ContactUsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ContactUsWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/client", ClientController
  end
end
