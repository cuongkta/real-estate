defmodule RealEstate.CurrentUserController do
  use RealEstateWeb, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: RealEstate.SessionController

  def show(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end