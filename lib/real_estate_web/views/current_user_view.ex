defmodule RealEstateWeb.CurrentUserView do
  use RealEstateWeb, :view

  def render("show.json", %{user: user}) do
    %{
      user: user
    }
  end


end
