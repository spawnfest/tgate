defmodule Tgate.Projects do
  alias Tgate.Projects.Commands.AddAbonent
  alias Tgate.Projects.Commands.CreateProject
  alias Tgate.Projects.Commands.RefreshAbonentCode
  alias Tgate.Projects.Commands.SendCode

  alias Tgate.Projects.Queries.OwnerQuery
  alias Tgate.Projects.Queries.ProjectQuery

  def fetch_project(owner_id) do
    ProjectQuery.fetch(owner_id)
  end

  def create_project(owner, attrs) do
    CreateProject.execute(owner, attrs)
  end

  def exchange_for_owner(user) do
    OwnerQuery.exchange(user)
  end

  def add_abonent(project, attrs) do
    AddAbonent.execute(project, attrs)
  end

  def refresh_abonent_code(abonent_id) do
    RefreshAbonentCode.execute(abonent_id)
  end

  def send_code(abonent_id) do
    SendCode.execute(abonent_id)
  end
end
