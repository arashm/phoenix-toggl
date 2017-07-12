defmodule PhoenixToggl.Repo.Migrations.CreatePhoenixToggl.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :firstname, :string, null: false
      add :lastname, :string
      add :email, :string, null: false
      add :encrypted_password, :string, null: false

      timestamps()
    end

  end
end
