defmodule AppDemoWeb.Api.RouterUser do
  @moduledoc """
    The user routers
  """
  use Phoenix.Router

  # get all users
  get "/", AppDemoWeb.Api.UserController, :get_all
end
