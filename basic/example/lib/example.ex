defmodule Membership do
  defstruct [:type, :price]
end

defmodule User do
  defstruct [:name, :membership]
end

defmodule Example do
  use Application
  # import Types
  alias UUID

  # define global variables
  @x 5
  @name "nguyencaole"

  # string and atom

  # TODO: main functions
  def start(_type, _agrs) do
    # IO.puts(@x)
    # IO.puts(@name)
    # IO.puts(Example.hello())
    # IO.puts(UUID.uuid4())
    Example.basic_type()
    Supervisor.start_link([], strategy: :one_for_one)
  end

  # defime functions
  def hello do
    # local variables
    y = 10
    IO.puts(y)

    # string and atom
    name = :gold
    status = Enum.random([:gold, :silver, :bronze])

    if name === :gold do
      IO.puts("Welcome to to fancy lounge, #{name}")
    else
      IO.puts("Get lost")
    end

    # switch case
    case status do
      :gold -> IO.puts("Welcome to the fancy louge, #{name}")
      :"not a member" -> IO.pust("Get subscribed")
      _ -> IO.puts("Get out brub")
    end

    # format
    :io.format("~.20f\n", [0.1])

    # time
    time = Time.new!(16, 30, 0, 0)
    date = Date.new!(2025, 1, 1)
    date_time = DateTime.new!(date, time, "Etc/UTC")
    IO.inspect(date_time)

    # time
    time = DateTime.new!(Date.new!(2024, 1, 1), Time.new!(0, 0, 0, 0), "Etc/UTC")
    time_till = DateTime.diff(time, DateTime.utc_now())
    IO.puts(time_till)
    IO.puts(DateTime.utc_now())
  end

  def main do
    # tuple
    memberships = {:bronze, :silver}
    memberships = Tuple.append(memberships, :gold)
    IO.inspect(memberships)

    # type variables
    gold_membership = %Membership{type: :gold, price: 25}

    users = [
      %User{name: "Nguyen", membership: gold_membership},
      %User{name: "Cao", membership: gold_membership},
      %User{name: "Le", membership: gold_membership}
    ]

    Enum.each(users, fn %User{name: name, membership: membership} ->
      IO.puts("#{name}, #{membership.type}")
    end)

    for user <- users do
      IO.puts(user.name)
    end

    # if else
    correct = :rand.uniform(11) - 1
    guess = IO.gets("Guess a number between 0 and 10: ") |> String.trim()

    if String.to_integer(guess) === correct do
      IO.puts("You win!")
    else
      IO.puts("You lose")
    end
  end

  def sum_and_average(numbers) do
    sum = Enum.sum(numbers)
    average = sum / Enum.count(numbers)
    {sum, average}
  end

  def print_number(numbers) do
    numbers |> Enum.join(" ") |> IO.puts()
  end

  def get_number_from_user do
  end

  def app do
    numbers = ["1", "2", "3", "4", "5"]
    numbers = Enum.map(numbers, &String.to_integer/1)
    print_number(numbers)
    IO.inspect(sum_and_average(numbers))
  end

  # basic type elixir
  def basic_type do
    IO.puts(:gold == "gold")
    IO.puts(:gold)

    IO.puts(rem(10, 3))

    IO.puts("Nguyen" <> "cao")

    IO.puts(Atom.to_charlist(:"Atom name"))

    list = String.split("NGUYEN CAO LE", " ")
    list = ["a" | list]
    IO.inspect(list)
    Enum.map(list, fn (ele) -> IO.puts(ele) end)
    # Enum.map(list, fn  ->  end)
    # IO.puts(Types.type_of("string"))

    maps = %{name: "nguyencaole", age: 25}
    IO.inspect(Map.keys(maps))

    keyword_list = [{:name, "nguyen"}, {:age, "nguyen"}]
    IO.inspect(keyword_list)

    IO.inspect(String.split("1-0-1-0", "-", [trim: true, parts: 2]))

    # @type key() :: atom()
    x = 1
    IO.puts(x)

    # param = "Hello"
    # sample_func = fn
    #   (param, name) -> "Hi #{param}"
    #   (^param, name) -> "Hi #{param}"
    # end
    # sample_func("Hello", "Sean")
    pie = 3.14
    case 3.14 do
      ^pie -> IO.puts("Yes")
      pie -> IO.puts("No")
    end

    cond do
      2 + 2 == 4 -> IO.puts("1")
      2 + 3 == 5 -> IO.puts("2")
    end

    # case do
    user = %{first: "Sean", last: "Callan"}

    case Map.fetch(user, :first) do
      {:ok, name} ->
        case is_bitstring(name) do
          {:ok, true} ->
            IO.puts("Check #{name}")
          error ->
            IO.puts("case error 1")
            false
      end

      error ->
        IO.puts("case error 2")
        false
    end

    # with do

    with {:ok, name} <- Map.fetch(user, :firstt), true <- is_bitstring(name) do
      IO.puts("Check #{name}")
      true
    else
      :error ->
        IO.puts("We don't have this item in map #{}")
        false
      _ ->
        IO.puts("It is odd")
        false
    end

    # function
    sum = fn (a, b) -> a + b end
    IO.puts(sum.(1, 2))

    #string
    string = "Elixir Block" |> String.upcase() |> String.split()
    IO.inspect(string)
  end
end
