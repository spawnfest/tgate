defmodule Tgate.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :role, :string, null: false
      add :status, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email], where: "status <> 'pending'")
  end
end
