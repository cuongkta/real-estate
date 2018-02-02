defmodule RealEstateWeb.CurrentUserController do
  use RealEstateWeb, :controller

  plug Guardian.Plug.EnsureAuthenticated, error_handler: RealEstateWeb.SessionController

  def show(conn, _) do
    user = RealEstate.Auth.Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end