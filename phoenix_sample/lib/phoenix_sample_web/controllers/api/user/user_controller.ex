defmodule PhoenixSampleWeb.User.ApiController do
  # init controller
  use PhoenixSampleWeb, :controller

  # index functions
  def index(conn, _params) do
    conn
    |> render("response.json", %{statusCode: "success", message: "success", data: %{}})
  end
end
