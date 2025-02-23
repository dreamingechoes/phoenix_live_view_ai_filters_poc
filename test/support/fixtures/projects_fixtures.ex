defmodule PhoenixLiveViewAiFiltersPoc.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixLiveViewAiFiltersPoc.Projects` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        code: "some code",
        description: "some description",
        estimation: "small",
        name: "some name",
        status: "active",
        target_date: ~D[2024-08-13],
        type: "internal"
      })
      |> PhoenixLiveViewAiFiltersPoc.Projects.create_project()

    project
  end
end
