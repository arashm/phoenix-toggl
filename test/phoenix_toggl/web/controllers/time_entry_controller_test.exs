defmodule PhoenixToggl.Web.TimeEntryControllerTest do
  use PhoenixToggl.Web.ConnCase

  alias PhoenixToggl.TimeBoundries
  alias PhoenixToggl.TimeBoundries.TimeEntry

  @create_attrs %{description: "some description", duration: 42, restarted_at: ~N[2010-04-17 14:00:00.000000], started_at: ~N[2010-04-17 14:00:00.000000], stopped_at: ~N[2010-04-17 14:00:00.000000]}
  @update_attrs %{description: "some updated description", duration: 43, restarted_at: ~N[2011-05-18 15:01:01.000000], started_at: ~N[2011-05-18 15:01:01.000000], stopped_at: ~N[2011-05-18 15:01:01.000000]}
  @invalid_attrs %{description: nil, duration: nil, restarted_at: nil, started_at: nil, stopped_at: nil}

  def fixture(:time_entry) do
    {:ok, time_entry} = TimeBoundries.create_time_entry(@create_attrs)
    time_entry
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, time_entry_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates time_entry and renders time_entry when data is valid", %{conn: conn} do
    conn = post conn, time_entry_path(conn, :create), time_entry: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, time_entry_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some description",
      "duration" => 42,
      "restarted_at" => ~N[2010-04-17 14:00:00.000000],
      "started_at" => ~N[2010-04-17 14:00:00.000000],
      "stopped_at" => ~N[2010-04-17 14:00:00.000000]}
  end

  test "does not create time_entry and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, time_entry_path(conn, :create), time_entry: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen time_entry and renders time_entry when data is valid", %{conn: conn} do
    %TimeEntry{id: id} = time_entry = fixture(:time_entry)
    conn = put conn, time_entry_path(conn, :update, time_entry), time_entry: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, time_entry_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "description" => "some updated description",
      "duration" => 43,
      "restarted_at" => ~N[2011-05-18 15:01:01.000000],
      "started_at" => ~N[2011-05-18 15:01:01.000000],
      "stopped_at" => ~N[2011-05-18 15:01:01.000000]}
  end

  test "does not update chosen time_entry and renders errors when data is invalid", %{conn: conn} do
    time_entry = fixture(:time_entry)
    conn = put conn, time_entry_path(conn, :update, time_entry), time_entry: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen time_entry", %{conn: conn} do
    time_entry = fixture(:time_entry)
    conn = delete conn, time_entry_path(conn, :delete, time_entry)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, time_entry_path(conn, :show, time_entry)
    end
  end
end
