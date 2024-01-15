defmodule PhoenixSample.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix :phoenix_demo
  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :phone, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :phone, :role])
    |> validate_required([:name, :email, :password, :phone, :role])
    |> unique_constraint(:email)
  end
end
