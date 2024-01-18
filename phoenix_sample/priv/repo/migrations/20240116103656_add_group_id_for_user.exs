defmodule PhoenixSample.Repo.Migrations.AddGroupIdForUser do
  use Ecto.Migration

  def change do
    alter table(:users, prefix: :phoenix_demo) do
      add :user_group_id, references(:user_group, on_delete: :delete_all), default: nil
    end
  end
end
