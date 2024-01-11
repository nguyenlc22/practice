# defmodule Types do
#   @doc """
#   ## Examples:

#     iex>Types.typeof("Hello World")
#     "binary"

#     iex>Types.typeof(1)
#     "integer"

#     iex>Types.typeof(self())
#     "pid"

#     iex>Types.typeof('this is char list')
#     "list"

#   """
#   def type_of(term) do
#     cond do
#       is_atom(term) -> "atom"
#       is_boolean(term) -> "boolean"
#       is_function(term) -> "function"
#       is_list(term) -> "list"
#       is_map(term) -> "map"
#       is_nil(term) -> "nil"
#       is_pid(term) -> "pid"
#       is_port(term) -> "port"
#       is_reference(term) -> "reference"
#       is_tuple(term) -> "tuple"
#       is_binary(term) -> "binary"
#       is_bitstring(term) -> "bitstring"
#       is_integer(term) -> "integer"
#       is_float(term) -> "float"
#       is_number(term) -> "number"
#       true -> :error
#     end
#   end

#   @equal_types %{
#     "number" => ["integer", "float"],
#     "string" => ["binary", "bitstring"]
#   }

#   @doc """
#   ## Examples:

#     iex> Specs.type_compare(1.3, "number" )
#     true
#     iex> Specs.type_compare(1.3, "integer")
#     false
#     iex> Specs.type_compare(1.3, "float")
#     true
#   """
#   @specs type_compare(any, binary) :: boolean
#   def type_compare(term, type) when is_binary(type) do
#     term_type = typeof(term)
#     term_type == type or term_type in (@equal_types[type] || [])
#   end
# end
