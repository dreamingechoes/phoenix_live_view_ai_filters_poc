defmodule PhoenixLiveViewAiFiltersPoc.Projects.Finders.ListProjects do
  @moduledoc """
  Returns a list of projects that match the given filters.

  ## Filter options

  * `code` - The code of the projects to filter by.
  * `estimation` - The estimation of the projects to filter by.
  * `name` - The name of the projects to filter by.
  * `status` - The status of the projects to filter by.
  * `target_date` - The target date of the projects to filter by.
  * `type` - The type of the projects to filter by.

  ## Sorting options

  * `sort_by` - The field to sort the projects by.
  * `order` - The order to sort the projects by. Default is `asc`.

  ## Examples

    iex> PhoenixLiveViewAiFiltersPoc.Projects.Finders.ListProjects.find(%{name: "Project 1"})
    [%PhoenixLiveViewAiFiltersPoc.Projects.Project{...}]
  """

  import Ecto.Query

  alias PhoenixLiveViewAiFiltersPoc.Projects.Project
  alias PhoenixLiveViewAiFiltersPoc.Repo

  @spec find(map()) :: [Project.t()]
  def find(opts \\ %{}) do
    query =
      base_query()
      |> filter_query(opts)
      |> sort(opts)

    Repo.all(query)
  end

  defp base_query() do
    from(project in Project, as: :project)
  end

  defp filter_query(query, opts) do
    Enum.reduce(opts, query, &apply_filter/2)
  end

  defp apply_filter({:code, value}, query),
    do: where(query, [project: project], project.code == ^value)

  defp apply_filter({:estimation, value}, query) when is_list(value),
    do: where(query, [project: project], project.estimation in ^value)

  defp apply_filter({:estimation, value}, query),
    do: where(query, [project: project], project.estimation == ^value)

  defp apply_filter({:name, value}, query),
    do: where(query, [project: project], ilike(project.name, ^"%#{value}%"))

  defp apply_filter({:status, value}, query) when is_list(value),
    do: where(query, [project: project], project.status in ^value)

  defp apply_filter({:status, value}, query),
    do: where(query, [project: project], project.status == ^value)

  defp apply_filter({:target_date, [date_from, date_to]}, query),
    do:
      where(
        query,
        [project: project],
        project.target_date >= ^to_date(date_from) and project.target_date <= ^to_date(date_to)
      )

  defp apply_filter({:type, value}, query) when is_list(value),
    do: where(query, [project: project], project.type in ^value)

  defp apply_filter({:type, value}, query),
    do: where(query, [project: project], project.type == ^value)

  defp apply_filter(_, query), do: query

  defp sort(query, %{sort_by: sort_field} = opts) do
    sort_order = Map.get(opts, :order, :asc)
    sort_by(query, sort_field, sort_order)
  end

  defp sort(query, _), do: query

  defp sort_by(query, field, order)
       when field in [:code, :estimation, :name, :status, :target_date, :type] do
    order_by(query, [project: project], [{^order, field(project, ^field)}])
  end

  defp sort_by(query, _, _), do: query

  defp to_date(%Date{} = value), do: value
  defp to_date(value), do: Date.from_iso8601!(value)
end
