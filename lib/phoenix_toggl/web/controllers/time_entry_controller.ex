defmodule PhoenixToggl.Web.TimeEntryController do
  use PhoenixToggl.Web, :controller

  alias PhoenixToggl.TimeBoundries
  alias PhoenixToggl.TimeBoundries.TimeEntry

  action_fallback PhoenixToggl.Web.FallbackController

  def index(conn, _params) do
    time_entries = TimeBoundries.list_time_entries()
    render(conn, "index.json", time_entries: time_entries)
  end

  def create(conn, %{"time_entry" => time_entry_params}) do
    with {:ok, %TimeEntry{} = time_entry} <- TimeBoundries.create_time_entry(time_entry_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_entry_path(conn, :show, time_entry))
      |> render("show.json", time_entry: time_entry)
    end
  end

  def show(conn, %{"id" => id}) do
    time_entry = TimeBoundries.get_time_entry!(id)
    render(conn, "show.json", time_entry: time_entry)
  end

  def update(conn, %{"id" => id, "time_entry" => time_entry_params}) do
    time_entry = TimeBoundries.get_time_entry!(id)

    with {:ok, %TimeEntry{} = time_entry} <- TimeBoundries.update_time_entry(time_entry, time_entry_params) do
      render(conn, "show.json", time_entry: time_entry)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_entry = TimeBoundries.get_time_entry!(id)
    with {:ok, %TimeEntry{}} <- TimeBoundries.delete_time_entry(time_entry) do
      send_resp(conn, :no_content, "")
    end
  end
end
