defmodule PhoenixLiveViewAiFiltersPoc.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  defmodule ProjectStatus do
    @moduledoc false

    def values, do: [:active, :done, :archived, :deleted, :draft]
  end

  defmodule ProjectType do
    @moduledoc false
    def values, do: [:internal, :external]
  end

  defmodule ProjectEstimation do
    @moduledoc false
    def values, do: [:extra_small, :small, :medium, :large, :extra_large]
  end

  schema "projects" do
    field :code, :string
    field :name, :string
    field :description, :string
    field :status, Ecto.Enum, values: ProjectStatus.values()
    field :type, Ecto.Enum, values: ProjectType.values()
    field :estimation, Ecto.Enum, values: ProjectEstimation.values()
    field :target_date, :date

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :code, :description, :status, :type, :estimation, :target_date])
    |> validate_required([:name])
  end
end
