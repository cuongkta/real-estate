defmodule RealEstate.Condos.Project do
  use Ecto.Schema
  import Ecto.Changeset
  alias RealEstate.Condos.Project
  alias RealEstate.Account.User

  schema "projects" do
    field :address, :string
    field :completed_at, :naive_datetime
    field :developer, :string
    field :listed_on, :naive_datetime
    field :name, :string
    field :tenure, :string


    belongs_to :user,     User

    timestamps()
  end

  @doc false
  def changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:name, :address, :developer, :tenure, :listed_on, :completed_at, :user_id])
    |> validate_required([:name, :address, :developer, :tenure, :listed_on, :completed_at, :user_id])
  end
end
