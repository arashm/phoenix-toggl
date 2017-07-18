defmodule PhoenixToggl.Web.CurrentUserController do
  use PhoenixToggl.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: PhoenixToggl.Web.SessionController

  def show(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end
