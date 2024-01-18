defmodule AppDemo.Repo.Migrations.AddGroupIdToUsersTables do
  use Ecto.Migration

  def change do
    alter table(:users, prefix: :auth) do
      add :user_group_id, references(:user_groups, on_delete: :delete_all), default: nil
    end
  end
end
