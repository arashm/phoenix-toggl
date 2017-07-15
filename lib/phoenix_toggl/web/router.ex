defmodule PhoenixToggl.Web.Router do
  use PhoenixToggl.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader
    plug Guardian.Plug.LoadResource
  end

  scope "/", PhoenixToggl.Web do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixToggl.Web do
    pipe_through :api

    scope "/v1" do
      post "/registrations", RegistrationController, :create

      resources "/sessions", SessionController, only: [:create, :delete]
    end
  end
end
