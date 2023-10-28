defmodule Tgate.Projects do
  alias Tgate.Projects.Commands.CreateProject
  alias Tgate.Projects.Queries.OwnerQuery

  def create_project(owner, attrs) do
    CreateProject.execute(owner, attrs)
  end

  def exchange_for_owner(user) do
    OwnerQuery.exchange(user)
  end
end
