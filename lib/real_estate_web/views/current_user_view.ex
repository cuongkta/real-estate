defmodule RealEstateWeb.CurrentUserView do
  use RealEstateWeb, :view

  def render("show.json", %{user: user}) do
    %{
      user:  %{
        id: user.id,
        email: user.email
      }
    }
  end


end
