defmodule Tgate.Projects do
  alias Tgate.Projects.Commands.CreateProject
  alias Tgate.Projects.Commands.AddAbonent
  alias Tgate.Projects.Commands.RefreshAbonentCode

  alias Tgate.Projects.Queries.OwnerQuery

  def create_project(owner, attrs) do
    CreateProject.execute(owner, attrs)
  end

  def exchange_for_owner(user) do
    OwnerQuery.exchange(user)
  end

  def add_abonent(project, attrs) do
    AddAbonent.execute(project, attrs)
  end

  def refresh_abonent_code(abonent) do
    RefreshAbonentCode.execute(abonent)
  end
end
