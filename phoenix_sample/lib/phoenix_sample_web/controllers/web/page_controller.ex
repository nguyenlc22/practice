defmodule PhoenixSampleWeb.PageController do
  # init controller
  use PhoenixSampleWeb, :controller
  # import module
  alias PhoenixSample.Repo.User, as: User_Repo

  def index(conn, _params) do
    User_Repo.get_all()
    render(conn, "index.html")
  end
end
