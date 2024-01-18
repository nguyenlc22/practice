defmodule PhoenixSampleWeb.Api.RouterAuth do
  use Phoenix.Router

  # register
  post "/register", PhoenixSampleWeb.Api.PageController, :register
  post "/login", PhoenixSampleWeb.Api.PageController, :login_with_email
end
