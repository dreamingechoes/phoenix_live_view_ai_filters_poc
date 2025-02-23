defmodule PhoenixLiveViewAiFiltersPoc.Projects.Finders.ListProjectsTest do
  use PhoenixLiveViewAiFiltersPoc.DataCase

  import PhoenixLiveViewAiFiltersPoc.ProjectsFixtures

  alias PhoenixLiveViewAiFiltersPoc.Projects.Finders.ListProjects

  describe "find/1" do
    test "filters by code" do
      project_1 = project_fixture(%{code: "code_1"})
      project_fixture(%{code: "code_2"})

      assert [project] = ListProjects.find(%{code: project_1.code})
      assert project.code == project_1.code
    end

    test "filters by estimation" do
      project_1 = project_fixture(%{estimation: "small"})
      project_fixture(%{estimation: "large"})

      assert [project] = ListProjects.find(%{estimation: project_1.estimation})
      assert project.estimation == project_1.estimation
    end

    test "filters by name" do
      project_1 = project_fixture(%{name: "Project example"})
      project_fixture(%{name: "Foo bar"})

      assert [project] = ListProjects.find(%{name: "Project"})
      assert project.name == project_1.name
    end

    test "filters by status" do
      project_1 = project_fixture(%{status: "active"})
      project_fixture(%{status: "draft"})

      assert [project] = ListProjects.find(%{status: project_1.status})
      assert project.status == project_1.status
    end

    test "filters by target date" do
      project_1 = project_fixture(%{target_date: ~D[2024-01-01]})
      project_fixture(%{target_date: ~D[2024-03-01]})

      assert [project] = ListProjects.find(%{target_date: [~D[2024-01-01], ~D[2024-02-01]]})
      assert project.target_date == project_1.target_date
    end

    test "filters by type" do
      project_1 = project_fixture(%{type: "internal"})
      project_fixture(%{type: "external"})

      assert [project] = ListProjects.find(%{type: project_1.type})
      assert project.type == project_1.type
    end

    test "sorts by field" do
      project_1 = project_fixture(%{name: "Project 1"})
      project_2 = project_fixture(%{name: "Project 2"})

      assert [^project_2, ^project_1] = ListProjects.find(%{sort_by: :name, order: :desc})
    end
  end
end
