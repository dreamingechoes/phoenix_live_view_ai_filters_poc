defmodule PhoenixLiveViewAiFiltersPocWeb.ProjectLive.Index do
  use PhoenixLiveViewAiFiltersPocWeb, :live_view

  alias PhoenixLiveViewAiFiltersPoc.Projects
  alias PhoenixLiveViewAiFiltersPoc.Projects.Project
  alias PhoenixLiveViewAiFiltersPoc.Projects.Services.BuildProjectFilters

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:filters, nil)
      |> assign(:query, nil)

    {:ok, stream(socket, :projects, filter_projects())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Project")
    |> assign(:project, Projects.get_project!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Project")
    |> assign(:project, %Project{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Projects")
    |> assign(:project, nil)
  end

  @impl true
  def handle_info(
        {PhoenixLiveViewAiFiltersPocWeb.ProjectLive.FormComponent, {:saved, project}},
        socket
      ) do
    {:noreply, stream_insert(socket, :projects, project)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    project = Projects.get_project!(id)
    {:ok, _} = Projects.delete_project(project)

    {:noreply, stream_delete(socket, :projects, project)}
  end

  @impl true
  def handle_event("trigger-search", %{"search" => %{"query" => query}}, socket) do
    filters =
      case BuildProjectFilters.call(query) do
        {:ok, filters} -> filters
        _ -> %{}
      end

    socket = assign(socket, :filters, filters)

    {:noreply, stream(socket, :projects, filter_projects(filters), reset: true)}
  end

  @impl true
  def handle_event("reset-search", _params, socket) do
    socket =
      socket
      |> assign(:filters, nil)
      |> assign(:query, "")

    {:noreply, stream(socket, :projects, filter_projects(), reset: true)}
  end

  defp filter_projects(filters \\ %{}) do
    Projects.list_projects(filters)
  end
end
