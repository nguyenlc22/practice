defmodule PhoenixSampleWeb.Api.UserView do
  use PhoenixSampleWeb, :view

  # response json
  def render("response.json", %{statusCode: statusCode, message: message, data: data}) do
    %{statusCode: statusCode, message: message, data: data}
  end
end
