# DATE 10/01/2024
## Mix

> Mix is the build tool for elixir and it will allow us to do things 
- Generate new projects `mix new name-project`
- Compile projects `mix compile` --> generated name-project app --> `iex -S mix` --> name-module.name-function
- Run projects `mix run -e "name-module.name-function"` or `mix run`
- Print string in elixir `IO.puts(:strings)`


## Elixir bacsic types

- `integers`
- `floats`
- `booleans`
- `atoms`
- `strings`
- `collections (maps, lists, tuples, keyword list)`

### Numbers (integers, floats)

Type `1 + 2` into the terminal (after opening `iex`):

```elixir
iex> 1 + 2
3
iex> 1.24 + 2
3.24
```

### Booleans

Elixir supports `true` and `false` as booleans.

```elixir
iex> true
true
iex> false
false

iex> is_boolean(true)
true
iex> is_boolean(1)
false
```

### Atoms
> Atoms là một kiểu dữ liệu mà tên của nó chính là giá trị nó được define
(some other languages call these Symbols).

```elixir
iex> :hello
:hello
iex> :hello == :world
false
```
One popular use of atoms in **`Elixir`** is to use them as messages
for [pattern matching](https://hexdocs.pm/elixir/pattern-matching.html).

### Strings

> Strings trong Elixir được define trong dấu `""`.

```elixir
iex> "Hello World"
"Hello world"

# You can print a string using the `IO` module
iex> IO.puts("Hello world")
"Hello world"
:ok

# Concatenation string
iex> name = "Hello"
"Hello"
iex> name <> " world!"
"Hello world!"

# String interpolation
iex> name = "nguyen"
"nguyen"
iex> "Hello #{name}"
"Hello nguyen"
```

### Collections

#### List
> Elixir sử dụng **`[]`** để định nghĩa một list, các phần tử trong list có thể là nhiều type khác nhau và non-unique

```elixir
iex> myList = [1,2,3]
iex> myList
[1,2,3]

iex> length(myList)
3
```

##### List Concatenation
```elixir
iex> [1, 2, 3] ++ [4, 5, 6]
[1, 2, 3, 4, 5, 6]
```

##### List subtraction
```elixir
iex> [1, true, 2, false, 3, true] -- [true, false]
[1, 2, 3, true]
```

##### Head / Tail
> Head có thể hiểu là phần tử đầu tiên trong list
> Tail là list các phần tử trong list trừ phần tử đầu tiên.
> Elixir hỗ trợ **`hd`** cho head và **`tl`** cho tail

```elixir
iex> hd ["1", "2", "3"]
"1"
iex> hd ["1", "2", "3"]
["2", "3"]
```

### Tuples
> Elixir sử dụng dấu **`{}`** để define một tuples
> Tuples khá tương đồng với list, nhưng không phù hợp làm việc với các data thay đổi thường xuyên.

```elixir
iex> tuple = {:ok, "hello"}
{:ok, "hello"}

# get element at index 1
iex> elem(tuple, 1)
"hello"

# get the size of the tuple
iex> tuple_size(tuple)
2
```

### Lists or Tuples?
- Sử dụng list với các data có sự lặp lại

When dealing with **large** lists or tuples:

- `Updating` a `list` (adding or removing elements) is **fast**
- `Updating` a `tuple` is **slow**

- `Reading` a `list` (getting its length or selecting an element) is **slow**
- `Reading` a `tuple` is **fast**

> source: http://stackoverflow.com/questions/31192923/lists-vs-tuples-what-to-use-and-when

### Maps
> Maps là kiểu dữ liệu key - value, trong Elixir được define **`%{}`**

```elixir
animal = %{
  name: "Rex",
  type: "dog",
  legs: 4
}
```

> Get value in maps with key
```elixir
name = animal.name
# Rex
```

> Ngoài ra ta có thể sử dụng pattern matching để get values from maps
```elixir
iex> %{
  name: name,
  type: type,
  legs: legs
} = animal
# we now have access to the values by typing the variable names
iex> name
# "Rex"
iex> type
# "dog"
iex> legs
# 4
```

#### Updating a value inside a map

```elixir
iex> animal = %{
  name: "Rex",
  type: "dog",
  legs: 4
}
iex> animal.name = "Max" # this cannot be done!
```
Bởi vì immutability of **`Elixir`**,
Do đó ta không thể update map thông qua dot notation
> link tham khảo mutiple and immutable: https://stackoverflow.com/questions/214714/mutable-vs-immutable-objects#:~:text=A%20mutable%20object%20is%20simply,is%20Pythons%20lists%20and%20tuples.

Do đó muốn _update_ a map trong Elixir, chúng ta sẽ tạo nột new map với các values mới cần define.
Có 2 cách để _update_:
1. Sử dụng fucntion
    Using `Map.put(map, key, value)`.

```elixir
iex> updatedAnimal = Map.put(animal, :name, "Max")
iex> updatedAnimal
# %{legs: 4, name: "Max", type: "dog"}
```

2. Sử dụng syntax (pattern matching)

```elixir
iex> %{animals | name: "Max"}
# %{legs: 4, name: "Max", type: "dog"}
```

> **NOTE:** Unlike the function method above,
> this syntax can only be used to UPDATE
> a current key-value pair inside the map,
> it cannot add a new key value pair.

### Keyword list
> Keyword lists are a data-structure used to pass options to functions

```elixir
iex> String.split("1 2 3", " ")
["1", "2", "3"]
iex> [foo: "bar", hello: "world"]
[foo: "bar", hello: "world"]
iex> [{:foo, "bar"}, {:hello, "world"}]
[foo: "bar", hello: "world"]
```

> The three characteristics of keyword lists highlight their importance:
- Keys are atoms.
- Keys are ordered.
- Keys do not have to be unique.

## Pattner Matching

### Match Operator

> The **`=`** operator is called the match operator.
- In Elixir used the **`=`** operator a couple times to assign variables
- The match operator chỉ sử dụng trong một số trường hợp đơn giản, trong trường hợp
dữ liệu phức tạp thì match operator không đáp ứng được.

```elixir
iex> {a, b, c} = {:hello, "world", 42}
{:hello, "world", 42}
iex> a
:hello
iex> b
"world"
```

Pattern match sẽ lỗi trong trường hợp (different size)
```elixir
>iex {a, b, c} = {:hello, "world"}
** (MatchError) no match of right hand side value: {:hello, "world"}
```

### Pin Operator
>  **`^`** is syntax pin operator in Elixir


# DATE 11/01/2024
## If/else and unless conditions
> Chú ý việc thay đổi giá trị một biến bên trong if/else or unless, nó chỉ thay đổi trong construct, giá trị được gán ban đầu không đổi
```elixir
iex> x = 1
1
iex> if true do
...>  x = x + 1
...> end
2
iex> x
1
```

> Trong trường hợp ta muốn thay đổi giá trị, ta phải return giá trị từ function
```elixir
iex> x = 1
1
iex> x = if true do
...>  x + 1
...> else
...>  x
...> end
2
```

## Case
> **`case`** allows us to compare a value against many patterns until we find a matching one:

```elixir
iex> case {1, 2, 3} do
...>  {4, 5, 6} ->
...>    "This clause won't match"
...>  {1, x, 3} ->
...>    "This clause will match and bind x to 2 in this clause"
...>  _ ->
...>    "This clause would match any value"
...> end
"This clause will match and bind x to 2 in this clause"
```

```elixir
iex> case {1, 2, 3} do
...>  {1, x, 3} when x > 0 ->
...>    "Will match"
...>  _ ->
...>    "Would match, if guard condition were not satisfied"
...> end
"Will match"
```

## Cond
> **`cond`** use to check different conditions and find the first one that does not evaluate to **`nil`** or **`false`**
```elixir
iex> cond do
...>  2 + 2 == 5 ->
...>    "This will not be true"
...>  2 * 2 == 3 ->
...>    "Nor this"
...>  1 + 1 == 2 ->
...>    "But this will"
...> end
"But this will"
```

## With...do...else
> Được dùng trong trường hợp có nhiều **`case`** lồng nhau để code clean hơn
- Nested case
```
case Repo.insert(changeset) do
    {:ok, user} ->
        case Guardian.encode_and_sign(user, :token, claims) do
        {:ok, token, full_claims} ->
            important_stuff(token, full_claims)
        error ->
            error
    end

    error ->
        error
end
```
- Used **`with...do`**
```
with {:ok, user} <- Repo.insert(changeset),
    {:ok, token, full_claims} <- Guardian.encode_and_sign(user, :token, claims) do
        important_stuff(token, full_claims)
end
```

# DATE 12/01/2024

## Function

### Anonymous functions
> Anonymous functions start with fn and end with end.

```elixir
iex> add = fn (a, b)-> a + b end
iex> add.(1, 2)
3
```
> Note a dot . between the variable add and parenthesis is required to invoke an anonymous functions.

> Define a new anonymous function that uses the add anonymous function we have previously defined:
```elixir
iex> double = fn a -> add.(a, a) end
iex> double.(5)
10
```

### Pattern matching in anonymous functions

> Pattern matching được dùng để define parameter trong fuction

```elixir
iex> handle_result = fn
...>  {:ok, result} -> IO.puts "Handling result..."
...>  {:ok, _} -> IO.puts "This would be never run as previous will be matched beforehand."
...>  {:error} -> IO.puts "An error has occurred!"
...> end

iex> handle_result.({:ok, some_result})
Handling result...
:ok
```

### Private Function
> Using **`defp`** to define private function, don't want other modules accessing a specific function
```elixir
defmodule Greeter do
  def hello(name), do: phrase() <> name
  defp phrase, do: "Hello, "
end

iex> Greeter.hello("Sean")
"Hello, Sean"

iex> Greeter.phrase
** (UndefinedFunctionError) function Greeter.phrase/0 is undefined or private
    Greeter.phrase()
```


### Guards
> Dùng để check input params 
```elixir
defmodule Greeter do
    def hello(names) when is_list(names) do
        names = Enum.join(names, ", ")
        IO.inspect(names)
    end
end

iex> Greeter.hello(["Sean", "Steve"])
"Sean, Steve"
```
- **`is_list`** is used check type parameter

### Default arguments
> Using **`argument \\ value`** for define init argument

## Modules
> Modules dùng để define các functions dưới một namespace. Trong modules cho define name, function, private function.

- Example
```
defmodule Math do
    # define variable
    @greeting "Hello"
    def sum(a, b) do
        a + b
    end
end
```

## Structs
> Structs are special maps with a defined set of keys and default values
> Using **`defstruct`** for define structs in elixir

```
defmodule Example.User do
  defstruct name: "Sean", roles: []
end

or

defmodule User do
  defstruct [:name, :roles]
end

using
%User{name: :nguyen, roles: []}
```

## Composition
> Dùng để tương tác function giữa các modules

1. Alisa 
```
defmodule Sayings.Greetings do
  def basic(name), do: "Hi, #{name}"
end

defmodule Example do
  # import modules from out example module
  alias Sayings.Greetings

  def greeting(name), do: Greetings.basic(name)
end

# Without alias

defmodule Example do
  def greeting(name), do: Sayings.Greetings.basic(name)
end
```
- Using **`:as`** for replace alisa modules
```
defmodule Example do
  alias Sayings.Greetings, as: Hi

  def print_message(name), do: Hi.basic(name)
end
```

2. Import
> We use **`import`** whenever we want to access functions or macros from other modules without using the fully-qualified name
> Chỉ Sử dụng đối với các modules có các public functions, private function không thể access from external

3. Require
> Elixir provides macros as a mechanism for meta-programming (writing code that generates code). Macros are expanded at compile time.