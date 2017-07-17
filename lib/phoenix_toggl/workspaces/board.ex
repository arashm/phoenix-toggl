defmodule PhoenixToggl.Workspaces.Board do
  use Ecto.Schema
  import Ecto.Changeset
  alias  PhoenixToggl.{Accounts.User, Workspaces.BoardUser, Repo}
  alias __MODULE__

  @derive {Poison.Encoder, only: [:id, :name]}

  schema "workspaces_boards" do
    field :name, :string

    belongs_to :owner, User, foreign_key: :user_id
    many_to_many :users, PhoenixToggl.Accounts.User,
      join_through: "board_users"

    timestamps()
  end

  @doc false
  def changeset(%Board{} = board, attrs) do
    board
    |> cast(attrs, [:name])
    |> validate_required([:name, :user_id])
    |> foreign_key_constraint(:user_id)
    |> insert_workspace_user()
  end

  def insert_workspace_user(changeset) do
    board_id = changeset.model.id
    user_id = changeset.model.user_id
    board_user_changeset = BoardUser.changeset(
      %BoardUser{}, %{board_id: board_id, user_id: user_id}
    )

    Repo.insert!(board_user_changeset)

    changeset
  end
end
