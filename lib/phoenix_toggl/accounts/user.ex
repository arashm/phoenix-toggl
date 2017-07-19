defmodule PhoenixToggl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias PhoenixToggl.Accounts.User

  @derive {Poison.Encoder, only: [:id, :firstname, :last_name, :email]}

  schema "accounts_users" do
    field :email, :string
    field :encrypted_password, :string
    field :firstname, :string
    field :lastname, :string
    field :password, :string, virtual: true

    has_many :time_entries, PhoenixToggl.TimeBoundries.TimeEntry
    many_to_many :boards, PhoenixToggl.Workspaces.Board,
      join_through: "board_users"

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :email, :password])
    |> validate_required([:firstname, :email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(
          current_changeset,
          :encrypted_password,
          Comeonin.Bcrypt.hashpwsalt(password)
        )
      _ ->
        current_changeset
    end
  end
end
