defmodule RealEstate.Auth.Pipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
    otp_app: :real_estate,
    error_handler: RealEstateWeb.SessionController,
    module: RealEstate.Auth.Guardian

  #plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifySession, claims: @claims
  plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"

  plug Guardian.Plug.LoadResource
  #plug Guardian.Plug.EnsureAuthenticated
  #plug Guardian.Plug.LoadResource, allow_blank: true
  #plug Guardian.Plug.EnsureAuthenticated
end