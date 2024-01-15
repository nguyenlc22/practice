defmodule PhoenixSampleWeb.RouterUser do
  use Phoenix.Router

  get "/", PhoenixSampleWeb.User.ApiController, :index
end
