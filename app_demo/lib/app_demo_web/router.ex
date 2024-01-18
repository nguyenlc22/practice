defmodule AppDemoWeb.Router do
  use AppDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AppDemoWeb do
    pipe_through :browser
  end

  # Other scopes may use custom stacks.
  scope "/api", AppDemoWeb do
    pipe_through [:browser, AppDemoWeb.JWTAuthPlug]

    # users router
    forward "/users", Api.RouterUser
  end

  # Other scopes may use custom stacks.
  scope "/api/auth", AppDemoWeb do
    pipe_through [:api]
    # auth router
    forward "/", Api.RouterAuth
  end
end
