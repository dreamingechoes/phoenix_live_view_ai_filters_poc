defmodule PhoenixLiveViewAiFiltersPoc.ProjectsTest do
  use PhoenixLiveViewAiFiltersPoc.DataCase

  alias PhoenixLiveViewAiFiltersPoc.Projects

  describe "projects" do
    alias PhoenixLiveViewAiFiltersPoc.Projects.Project

    import PhoenixLiveViewAiFiltersPoc.ProjectsFixtures

    @invalid_attrs %{
      name: nil
    }

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Projects.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Projects.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{
        code: "some code",
        name: "some name",
        status: "active",
        type: "internal",
        description: "some description",
        estimation: "small",
        target_date: ~D[2024-08-13]
      }

      assert {:ok, %Project{} = project} = Projects.create_project(valid_attrs)
      assert project.code == "some code"
      assert project.name == "some name"
      assert project.status == :active
      assert project.type == :internal
      assert project.description == "some description"
      assert project.estimation == :small
      assert project.target_date == ~D[2024-08-13]
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()

      update_attrs = %{
        code: "some updated code",
        name: "some updated name",
        status: "done",
        type: "external",
        description: "some updated description",
        estimation: "large",
        target_date: ~D[2024-08-14]
      }

      assert {:ok, %Project{} = project} = Projects.update_project(project, update_attrs)
      assert project.code == "some updated code"
      assert project.name == "some updated name"
      assert project.status == :done
      assert project.type == :external
      assert project.description == "some updated description"
      assert project.estimation == :large
      assert project.target_date == ~D[2024-08-14]
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_project(project, @invalid_attrs)
      assert project == Projects.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Projects.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Projects.change_project(project)
    end
  end
end
