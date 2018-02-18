defmodule RealEstateWeb.ProjectView do
  use RealEstateWeb, :view
  alias RealEstateWeb.ProjectView

  def render("index.json", %{projects: projects}) do
    %{data: render_many(projects, ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{id: project.id,
      name: project.name,
      address: project.address,
      developer: project.developer,
      tenure: project.tenure,
      listed_on: project.listed_on,
      user_id: project.user_id, 
      completed_at: project.completed_at}
  end
end
