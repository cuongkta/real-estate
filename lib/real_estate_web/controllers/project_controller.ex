
defmodule RealEstateWeb.ProjectController do
  use RealEstateWeb, :controller

  alias RealEstate.Condos
  alias RealEstate.Condos.Project
  plug Guardian.Plug.EnsureAuthenticated, error_handler: RealEstateWeb.SessionController
  plug :load_and_authorize_resource, model: Project, except: :show

  action_fallback RealEstateWeb.FallbackController


  def index(conn, _params) do
    projects = Condos.list_projects()
    render(conn, "index.json", projects: projects)
  end

  def create(conn, %{"project" => project_params}) do
    Exq.enqueue_in(Exq, "subscribe", 300, RealEstateWeb.SubcribeWorker, ["create project"])
    with {:ok, %Project{} = project} <- Condos.create_project(project_params) do
      conn
      |> put_status(:created)
      #|> put_resp_header("location", api_v1_project_path(conn, :show, project))
      |> render("show.json", project: project)
    end
  end

  def show(conn, %{"id" => id}) do
    project = Condos.get_project!(id)
    render(conn, "show.json", project: project)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Condos.get_project!(id)

    with {:ok, %Project{} = project} <- Condos.update_project(project, project_params) do
      render(conn, "show.json", project: project)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Condos.get_project!(id)
    with {:ok, %Project{}} <- Condos.delete_project(project) do
      send_resp(conn, :no_content, "")
    end
  end
end
