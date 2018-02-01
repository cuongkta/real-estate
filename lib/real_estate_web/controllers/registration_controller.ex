#require IEx
defmodule RealEstateWeb.RegistrationController  do
  use RealEstateWeb, :controller
  alias RealEstate.Account.User
  alias RealEstate.Repo
  plug :scrub_params, "user" when action in [:create]
  
  

  def create(conn, %{"user" => user_params}) do
    
    changeset = User.changeset(%User{}, user_params)
    #IEx.pry
    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, token, _full_claims} = RealEstate.Auth.Guardian.encode_and_sign(user)

        conn
        |> put_status(:created)
        |> render(RealEstateWeb.SessionView, "show.json", jwt: token, user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(RealEstateWeb.RegistrationView, "error.json", changeset: changeset)
    end
  end
end