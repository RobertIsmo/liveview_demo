defmodule LiveviewDemo.Repo.Migrations.CreateCounters do
  use Ecto.Migration

  def change do
    create table(:counters) do
      add :slug, :string, null: false
      add :name, :string, null: false
      add :count, :integer, default: 3, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:counters, [:name])
    create unique_index(:counters, [:slug])
  end
end
