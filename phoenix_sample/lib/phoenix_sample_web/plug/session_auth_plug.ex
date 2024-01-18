defmodule PhoenixSampleWeb.SessionAuthPlug do
  @moduledoc """
    The pipelines JWT Auth Plug
  """
  use PhoenixSampleWeb, :controller
  import Plug.Conn

  alias PhoenixSample.Repo.User, as: UserRepo
  alias PhoenixSample.Schema.User, as: UserSchema
  alias PhoenixSampleWeb.Utils.Token, as: AuthToken
  alias PhoenixSampleWeb.Utils.Functional, as: UtilsFunc

  def init(opts), do: opts

  def call(conn, _) do
    bearer = conn |> get_session(:token)

    if bearer == nil do
      conn |> redirect(to: Routes.auth_path(conn, :init_login))
    else
      token = bearer |> String.split(" ") |> List.last()

      with {:ok, %{"user_id" => user_id}} <- UtilsFunc.op(:verify_token, UtilsFunc.verify_token(token)),
        %UserSchema{} = user <- UserRepo.get_user_by_id(user_id) do
        conn |> assign(:current_user, user)
      else
        {:verify_token, _reason} -> conn |> redirect(to: Routes.auth_path(conn, :init_login))
        _ -> conn |> redirect(to: Routes.auth_path(conn, :init_login))
      end
    end
  end
end
