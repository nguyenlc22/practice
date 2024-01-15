defmodule PhoenixSample.Repo.User do

  # get all users from db
  def get_all() do
    IO.inspect(PhoenixSample.Schema.User |> PhoenixSample.Repo.all)
  end
end
