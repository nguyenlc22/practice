defmodule Exircises do
  # alias MatrixReloaded.Matrix
  # import Nx.Defn

  def start(_type, _agrs) do
    # init array
    array = [[1, 2, 3], [1, 2, 3], [1, 2, 3]]
    # IO.inspect(array)
    IO.puts("##########")
    for ele <- array do
      IO.inspect(ele)
    end

    IO.puts("##########")
    new_list = []
    index = 0
    for ele <- array do
      # IO.inspect(Enum.fetch(ele, index))
      # list_proc =
      #   for item <- array do
      #     IO.inspect(Enum.fetch(item, index))
      #   end
      index = if true do index + 1 else index end

      IO.puts(index)
          # {:ok, ele_fetch} <- Enum.fetch(item, index) do
        # IO.inspect(ele_fetch)
      # IO.inspect(ele_fetch)
    end
    Supervisor.start_link([], strategy: :one_for_one)
  end
end
