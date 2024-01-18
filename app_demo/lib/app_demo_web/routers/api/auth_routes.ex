defmodule AppDemoWeb.Api.RouterAuth do
  use Phoenix.Router

  # register
  post "/register", AppDemoWeb.Api.PageController, :register
  post "/login", AppDemoWeb.Api.PageController, :login_with_email
end
