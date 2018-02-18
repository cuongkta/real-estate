defmodule RealEstate.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :address, :string
      add :developer, :string
      add :tenure, :string
      add :listed_on, :naive_datetime
      add :completed_at, :naive_datetime
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

  end
end
