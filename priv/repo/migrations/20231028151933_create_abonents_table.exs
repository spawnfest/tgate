defmodule Tgate.Repo.Migrations.CreateAbonentsTable do
  use Ecto.Migration

  def change do
    create table(:abonents) do
      add :name, :string, null: false
      add :status, :string, null: false

      add :invite_code, :string
      add :telegram_id, :bigint

      add :project_id, references(:projects, on_delete: :delete_all, on_update: :restrict),
        null: false

      timestamps()
    end

    create unique_index(:abonents, [:project_id, :name])
    create unique_index(:abonents, [:project_id, :telegram_id], where: "telegram_id IS NOT NULL")
  end
end
