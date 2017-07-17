defmodule PhoenixToggl.Repo.Migrations.CreatePhoenixToggl.Workspaces.Board do
  use Ecto.Migration

  def change do
    create table(:workspaces_boards) do
      add :name, :string
      add :user_id, references(:accounts_users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:workspaces_boards, [:user_id])
  end
end
