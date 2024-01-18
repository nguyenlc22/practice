defmodule AppDemoWeb.Api.UserController do
  @moduledoc """
    The User Controller
  """
  use AppDemoWeb, :controller

  alias AppDemo.Repo.User, as: UserRepo
  alias AppDemo.Schema.User, as: UserSchema
  alias AppDemoWeb.Utils.Functional, as: UtilsFunc

  @doc """
    - GET ALL USER
  """
  def get_all(conn, params) do
    # execute get all users
    cond do
      is_nil(conn.status) ->
        with users <- UserRepo.get_all(params) do
          conn |> render("response.json", %{statusCode: 200, message: "Get all users success.", data: users})
        else
          _ -> render("response.json", %{statusCode: 500, message: "Internal server error!", data: %{}})
        end
      true -> conn |> render("response.json", %{statusCode: conn.status, message: conn.assigns.msg_error, data: %{}})
    end
  end
end
