defmodule PhoenixSample.Schema.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :phoenix_demo
  schema "user_group" do
    field :title, :string
    has_many :users, PhoenixSample.Schema.User
    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> unique_constraint(:title)
  end
end
