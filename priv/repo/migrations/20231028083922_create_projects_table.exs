defmodule Tgate.Repo.Migrations.CreateProjectsTable do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :string, null: false

      add :owner_id, references(:users, on_delete: :delete_all, on_update: :restrict), null: false

      timestamps()
    end

    create unique_index(:projects, [:owner_id])
  end
end
