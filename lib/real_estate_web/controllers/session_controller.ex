defmodule RealEstateWeb.SessionController do
  use RealEstateWeb, :controller

  plug :scrub_params, "session" when action in [:create]

  def create(conn, %{"session" => session_params}) do
    case RealEstate.Auth.authenticate_user(session_params) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = RealEstate.Auth.Guardian.encode_and_sign(user)

        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user)

      :error ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
    end
  end


  def auth_error(conn, _params, _opts) do
    conn
    |> put_status(:forbidden)
    |> render(RealEstateWeb.SessionView, "forbidden.json", error: "Not Authenticated")
  end

  
end