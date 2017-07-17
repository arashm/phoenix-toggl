defmodule PhoenixToggl.WorkspacesTest do
  use PhoenixToggl.DataCase

  alias PhoenixToggl.Workspaces

  describe "boards" do
    alias PhoenixToggl.Workspaces.Board

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Workspaces.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert Workspaces.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert Workspaces.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      assert {:ok, %Board{} = board} = Workspaces.create_board(@valid_attrs)
      assert board.name == "some name"
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Workspaces.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, board} = Workspaces.update_board(board, @update_attrs)
      assert %Board{} = board
      assert board.name == "some updated name"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = Workspaces.update_board(board, @invalid_attrs)
      assert board == Workspaces.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = Workspaces.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> Workspaces.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = Workspaces.change_board(board)
    end
  end
end
