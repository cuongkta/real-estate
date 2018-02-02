defmodule RealEstateWeb.Router do
  use RealEstateWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    #plug Guardian.Plug.VerifyHeader
    #plug Guardian.Plug.LoadResource
    #plug RealEstate.Auth.Pipeline
  end

  pipeline :unauthorized do
    plug :fetch_session
  end

  pipeline :authorized do
    plug :fetch_session
    plug RealEstate.Auth.Pipeline
  end


  scope "/", RealEstateWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", RealEstateWeb, as: :api do
    pipe_through :api
    scope "/v1", as: :v1 do
      scope "/" do
        pipe_through :unauthorized
        post "/sessions", SessionController, :create
        post "/registrations", RegistrationController, :create
      end

      scope "/" do
        pipe_through :authorized
  
        delete "/sessions", SessionController, :delete
        get "/current_user", CurrentUserController, :show
        resources "/users", UserController, except: [:new, :edit]
      end
      
          
    end
  end
end
