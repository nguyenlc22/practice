# ELIXIR BASIC

## 1. Mix

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

###### List subtraction
```elixir
iex> [1, true, 2, false, 3, true] -- [true, false]
[1, 2, 3, true]
```

###### Head / Tail
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

2. Sử dụng syntax (partern matching)

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