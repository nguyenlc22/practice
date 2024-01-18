defmodule PhoenixSampleWeb.Api.RouterUser do
  @moduledoc """
    The user routers
  """
  use Phoenix.Router

  # get all users
  get "/", PhoenixSampleWeb.Api.UserController, :get_all
end
