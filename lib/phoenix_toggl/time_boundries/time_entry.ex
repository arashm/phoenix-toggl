defmodule PhoenixToggl.TimeBoundries.TimeEntry do
  use Ecto.Schema
  use Timex
  import Ecto.{ Query, Changeset }
  alias PhoenixToggl.TimeBoundries.TimeEntry

  schema "time_boundries_time_entries" do
    field :description, :string
    field :duration, :integer
    field :restarted_at, :naive_datetime
    field :started_at, :naive_datetime
    field :stopped_at, :naive_datetime

    belongs_to :user, Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%TimeEntry{} = time_entry, attrs) do
    time_entry
    |> cast(attrs, [:description, :started_at, :stopped_at, :restarted_at, :duration])
    |> validate_required([:started_at, :user_id])
    |> foreign_key_constraint(:user_id)
  end

  @doc """
  Creates a default changeset and sets the first time_range
  """
  def start_changeset(model, params \\ :empty) do
    model
    |> changeset(params)
    |> put_change(:duration, 0)
  end

  @doc """
  Creates a default changeset and calculates the duration depending on
  if the TimeEntry has been restarted or not.
  """
  def stop_changeset(model, params \\ :empty) do
    duration = case model.restarted_at do
      nil ->
        Timex.diff(model.started_at, params.stopped_at, :secs)
      restarted_at ->
        model.duration + Timex.diff(restarted_at, params.stopped_at, :secs)
    end

    model
    |> changeset(params)
    |> put_change(:duration, duration)
  end

  @doc """
  Creates a default changeset and sets the stop key value
  on the last time_range
  """
  def restart_changeset(model, params \\ :empty) do
    model
    |> changeset(params)
    |> cast(
      params, [:description, :stopped_at, :duration, :workspace_id, :restarted_at]
    )
    |> validate_required([:restarted_at])
    |> put_change(:stopped_at, nil)
  end

  @doc """
  Returns a start_changeset
  """
  def start(time_entry, attrs) do
    time_entry
    |> start_changeset(attrs)
  end

  @doc """
  Returns a stop_changeset
  """
  def stop(time_entry, date_time \\ Timex.now) do
    time_entry
    |> stop_changeset(%{stopped_at: date_time})
  end

  @doc """
  Returns a restart_changeset
  """
  def restart(time_entry, date_time \\ Timex.now) do
    time_entry
    |> restart_changeset(%{restarted_at: date_time})
  end

  def active_for_user(query, user_id) do
    from t in query,
      where: t.user_id == ^user_id and is_nil(t.stopped_at)
  end

  def not_active_for_user(query, user_id) do
    from t in query,
      where: t.user_id == ^user_id and not(is_nil(t.stopped_at))
  end

  def sorted(query) do
    from t in query,
      order_by: [desc: t.stopped_at]
  end

  def total_duration_for_date(query, date) do
    from t in query,
      select: sum(t.duration),
      where: fragment("date(?) = date(?)", t.started_at, type(^date, Ecto.Date))
  end

  def by_ids(query \\ TimeEntry, ids) do
    from t in query,
      where: t.id in ^ids
  end
end
