defmodule PhoenixToggl.Repo.Migrations.CreatePhoenixToggl.TimeBoundries.TimeEntry do
  use Ecto.Migration

  def change do
    create table(:time_boundries_time_entries) do
      add :description, :string
      add :started_at, :naive_datetime
      add :stopped_at, :naive_datetime
      add :restarted_at, :naive_datetime
      add :duration, :integer
      add :user_id, references(:accounts_users, on_delete: :delete_all)
      add :board_id, references(:boards_users, on_delete: :delete_all)

      timestamps()
    end

    create index(:time_boundries_time_entries, [:user_id])
  end
end
