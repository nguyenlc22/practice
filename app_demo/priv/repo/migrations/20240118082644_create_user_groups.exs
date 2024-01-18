defmodule AppDemo.Repo.Migrations.CreateUserGroups do
  use Ecto.Migration

  def change do
    create table(:user_groups, prefix: :auth) do
      add :title, :string
      add :roles, :map

      timestamps()
    end

    create unique_index(:user_groups, [:title], prefix: :auth)
  end
end
