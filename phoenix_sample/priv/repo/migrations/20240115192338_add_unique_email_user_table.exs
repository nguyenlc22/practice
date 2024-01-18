defmodule PhoenixSample.Repo.Migrations.AddUniqueEmailUserTable do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:email], prefix: :phoenix_demo)
  end
end
