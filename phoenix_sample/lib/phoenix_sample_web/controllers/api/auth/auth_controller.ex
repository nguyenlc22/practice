defmodule PhoenixSampleWeb.Auth.ApiController do
  # init controller
  use PhoenixSampleWeb, :controller

  # register functions
  def register(conn, _params) do
    conn
    |> render("response.json", %{statusCode: "success", message: "register", data: %{}})
  end
end
