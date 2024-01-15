defmodule Exircises do
  # alias MatrixReloaded.Matrix
  # import Nx.Defn

  def start(_type, _agrs) do
    # init array
    array = [[1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5]]
    # IO.inspect(array)
    IO.puts("-----------------------------")
    for ele <- array do
      IO.inspect(ele)
    end

    IO.puts("-----------------------------")
    {_, result} = Enum.reduce(array, {0, []}, fn ele, {index, result} ->
      # IO.inspect(Enum.fetch(array, index))
      array_result = for item <- array do
        # {:ok, ele_get} = Enum.fetch!(item, index)
        Enum.fetch!(item, index)
      end
      # IO.inspect(array_result)
      {index + 1, result ++ [array_result]}
    end)

    for ele <- result do
      IO.inspect(ele)
    end
    Supervisor.start_link([], strategy: :one_for_one)
  end
end
