defmodule PhoenixSample.Repo.Migrations.CreateUserGroup do
  use Ecto.Migration

  def change do
    create table(:user_group, prefix: :phoenix_demo) do
      add :title, :string

      timestamps()
    end

    create unique_index(:user_group, [:title], prefix: :phoenix_demo)
  end
end
