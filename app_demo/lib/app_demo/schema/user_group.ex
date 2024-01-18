defmodule AppDemo.Schema.UserGroup do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :auth
  schema "user_groups" do
    field :roles, :map
    field :title, :string
    has_many :users, AppDemo.Schema.User

    timestamps()
  end

  @doc false
  def changeset(user_group, attrs) do
    user_group
    |> cast(attrs, [:title, :roles])
    |> validate_required([:title, :roles])
  end
end
