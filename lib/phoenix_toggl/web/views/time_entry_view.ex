defmodule PhoenixToggl.Web.TimeEntryView do
  use PhoenixToggl.Web, :view
  alias PhoenixToggl.Web.TimeEntryView

  def render("index.json", %{time_entries: time_entries}) do
    %{data: render_many(time_entries, TimeEntryView, "time_entry.json")}
  end

  def render("show.json", %{time_entry: time_entry}) do
    %{data: render_one(time_entry, TimeEntryView, "time_entry.json")}
  end

  def render("time_entry.json", %{time_entry: time_entry}) do
    %{id: time_entry.id,
      description: time_entry.description,
      started_at: time_entry.started_at,
      stopped_at: time_entry.stopped_at,
      restarted_at: time_entry.restarted_at,
      duration: time_entry.duration}
  end
end
