defmodule PhoenixSampleWeb.RouterAuth do
  use Phoenix.Router

  # register
  post "/register", PhoenixSampleWeb.Auth.ApiController, :register
end
