defmodule PhoenixSampleWeb.AdminController do
  @moduledoc """
    The Admin Controller
  """
  use PhoenixSampleWeb, :controller

  # import module
  alias PhoenixSample.Repo.User, as: UserRepo
  alias PhoenixSample.Schema.User, as: UserSchema
  alias PhoenixSampleWeb.Utils.Functional, as: UtilsFunc

  # main functions
  def index(conn, params) do
    data = UserRepo.get_all(params)
    # TODO: check page and total pages for re-get data
    if data.page < data.total_pages do
      params = Map.merge(params, %{page: data.page + 1})
      data = UserRepo.get_all(params)
    end

    # TODO: get list users
    %{entries: list_users} = data

    conn
    |> put_layout({PhoenixSampleWeb.LayoutView, :admin})
    |> render("main.html", users: list_users)
  end

  def mount(_params, _session, socket) do
    temperature = 70 # Let's assume a fixed temperature for now
    {:ok, assign(socket, :temperature, temperature)}
  end

  def handle_event("inc_temperature", _params, socket) do
    IO.inspect("inc_temperature")
    # {:noreply, update(socket, :temperature, &(&1 + 1))}
  end
end
