defmodule PhoenixToggl.Workspaces.BoardUser do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias __MODULE__
  alias  PhoenixToggl.{Board, User}

  schema "boards_users" do
    belongs_to :board, Board
    belongs_to :user, User

    timestamps()
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(%BoardUser{} = board_user, attrs \\ :empty) do
    board_user
    |> cast(attrs, [:user_id, :board_id])
    |> validate_required([:user_id, :board_id])
    |> foreign_key_constraint(:board_id)
    |> foreign_key_constraint(:user_id)
  end

  def find_by_workspace_and_user(query \\ %BoardUser{}, board_id, user_id) do
    from u in query, where: u.user_id == ^user_id and u.board_id == ^board_id
  end
end
