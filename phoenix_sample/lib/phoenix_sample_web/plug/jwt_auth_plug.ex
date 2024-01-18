defmodule PhoenixSampleWeb.JWTAuthPlug do
  @moduledoc """
    The pipelines JWT Auth Plug
  """
  import Plug.Conn

  alias PhoenixSample.Repo.User, as: UserRepo
  alias PhoenixSample.Schema.User, as: UserSchema
  alias PhoenixSampleWeb.Utils.Token, as: AuthToken
  alias PhoenixSampleWeb.Utils.Functional, as: UtilsFunc

  def init(opts), do: opts

  def call(conn, _) do
    bearer = get_req_header(conn, "authorization") |> List.first()

    if bearer == nil do
      conn |> put_status(401) |> assign(:msg_error, "Please provide access token!")
    else
      token = bearer |> String.split(" ") |> List.last()

      with {:ok, %{"user_id" => user_id}} <- UtilsFunc.op(:verify_token, UtilsFunc.verify_token(token)),
        %UserSchema{} = user <- UserRepo.get_user_by_id(user_id) do
        conn |> assign(:current_user, user)
      else
        {:verify_token, _reason} -> conn |> put_status(401) |> assign(:msg_error, "Token is expired!")
        _ -> conn |> put_status(500) |> assign(:msg_error, "Internal server error!")
      end
    end
  end
end
