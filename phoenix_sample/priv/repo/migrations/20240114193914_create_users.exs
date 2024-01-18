defmodule PhoenixSample.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, prefix: :phoenix_demo) do
      add :name, :string
      add :email, :string
      add :password, :string
      add :phone, :string
      add :role, :string

      timestamps()
    end

    # create unique_index(:users, [:email], prefix: :phoenix_demo)
  end
end
