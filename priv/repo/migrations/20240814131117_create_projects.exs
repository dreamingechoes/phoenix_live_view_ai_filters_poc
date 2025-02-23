defmodule PhoenixLiveViewAiFiltersPoc.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string
      add :code, :string
      add :description, :text
      add :status, :string
      add :type, :string
      add :estimation, :string
      add :target_date, :date

      timestamps(type: :utc_datetime)
    end
  end
end
