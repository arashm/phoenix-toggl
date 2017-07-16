defmodule PhoenixToggl.TimeBoundriesTest do
  use PhoenixToggl.DataCase

  alias PhoenixToggl.TimeBoundries

  describe "time_entries" do
    alias PhoenixToggl.TimeBoundries.TimeEntry

    @valid_attrs %{description: "some description", duration: 42, restarted_at: ~N[2010-04-17 14:00:00.000000], started_at: ~N[2010-04-17 14:00:00.000000], stopped_at: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{description: "some updated description", duration: 43, restarted_at: ~N[2011-05-18 15:01:01.000000], started_at: ~N[2011-05-18 15:01:01.000000], stopped_at: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{description: nil, duration: nil, restarted_at: nil, started_at: nil, stopped_at: nil}

    def time_entry_fixture(attrs \\ %{}) do
      {:ok, time_entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> TimeBoundries.create_time_entry()

      time_entry
    end

    test "list_time_entries/0 returns all time_entries" do
      time_entry = time_entry_fixture()
      assert TimeBoundries.list_time_entries() == [time_entry]
    end

    test "get_time_entry!/1 returns the time_entry with given id" do
      time_entry = time_entry_fixture()
      assert TimeBoundries.get_time_entry!(time_entry.id) == time_entry
    end

    test "create_time_entry/1 with valid data creates a time_entry" do
      assert {:ok, %TimeEntry{} = time_entry} = TimeBoundries.create_time_entry(@valid_attrs)
      assert time_entry.description == "some description"
      assert time_entry.duration == 42
      assert time_entry.restarted_at == ~N[2010-04-17 14:00:00.000000]
      assert time_entry.started_at == ~N[2010-04-17 14:00:00.000000]
      assert time_entry.stopped_at == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_time_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TimeBoundries.create_time_entry(@invalid_attrs)
    end

    test "update_time_entry/2 with valid data updates the time_entry" do
      time_entry = time_entry_fixture()
      assert {:ok, time_entry} = TimeBoundries.update_time_entry(time_entry, @update_attrs)
      assert %TimeEntry{} = time_entry
      assert time_entry.description == "some updated description"
      assert time_entry.duration == 43
      assert time_entry.restarted_at == ~N[2011-05-18 15:01:01.000000]
      assert time_entry.started_at == ~N[2011-05-18 15:01:01.000000]
      assert time_entry.stopped_at == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_time_entry/2 with invalid data returns error changeset" do
      time_entry = time_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = TimeBoundries.update_time_entry(time_entry, @invalid_attrs)
      assert time_entry == TimeBoundries.get_time_entry!(time_entry.id)
    end

    test "delete_time_entry/1 deletes the time_entry" do
      time_entry = time_entry_fixture()
      assert {:ok, %TimeEntry{}} = TimeBoundries.delete_time_entry(time_entry)
      assert_raise Ecto.NoResultsError, fn -> TimeBoundries.get_time_entry!(time_entry.id) end
    end

    test "change_time_entry/1 returns a time_entry changeset" do
      time_entry = time_entry_fixture()
      assert %Ecto.Changeset{} = TimeBoundries.change_time_entry(time_entry)
    end
  end
end
