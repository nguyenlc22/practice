defmodule AppDemoWeb.Api.UserView do
  use AppDemoWeb, :view

  # response json
  def render("response.json", %{statusCode: statusCode, message: message, data: data}) do
    %{statusCode: statusCode, message: message, data: data}
  end
end
