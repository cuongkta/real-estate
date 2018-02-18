defmodule RealEstate.CondosTest do
  use RealEstate.DataCase

  alias RealEstate.Condos

  describe "projects" do
    alias RealEstate.Condos.Project

    @valid_attrs %{address: "some address", completed_at: ~N[2010-04-17 14:00:00.000000], developer: "some developer", listed_on: ~N[2010-04-17 14:00:00.000000], name: "some name", tenure: "some tenure"}
    @update_attrs %{address: "some updated address", completed_at: ~N[2011-05-18 15:01:01.000000], developer: "some updated developer", listed_on: ~N[2011-05-18 15:01:01.000000], name: "some updated name", tenure: "some updated tenure"}
    @invalid_attrs %{address: nil, completed_at: nil, developer: nil, listed_on: nil, name: nil, tenure: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Condos.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Condos.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Condos.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Condos.create_project(@valid_attrs)
      assert project.address == "some address"
      assert project.completed_at == ~N[2010-04-17 14:00:00.000000]
      assert project.developer == "some developer"
      assert project.listed_on == ~N[2010-04-17 14:00:00.000000]
      assert project.name == "some name"
      assert project.tenure == "some tenure"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Condos.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, project} = Condos.update_project(project, @update_attrs)
      assert %Project{} = project
      assert project.address == "some updated address"
      assert project.completed_at == ~N[2011-05-18 15:01:01.000000]
      assert project.developer == "some updated developer"
      assert project.listed_on == ~N[2011-05-18 15:01:01.000000]
      assert project.name == "some updated name"
      assert project.tenure == "some updated tenure"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Condos.update_project(project, @invalid_attrs)
      assert project == Condos.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Condos.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Condos.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Condos.change_project(project)
    end
  end
end
