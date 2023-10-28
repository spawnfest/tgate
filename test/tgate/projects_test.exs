defmodule Tgate.ProjectsTest do
  use Tgate.DataCase, async: true

  alias Tgate.Factory

  alias Tgate.Projects
  alias Tgate.Projects.Schemas.Owner

  test "error on not existing owner" do
    assert {:error, changeset} =
             Projects.create_project(%Owner{id: 0}, %{name: "My first project"})

    expected_errors = [owner_id: ["does not exist"]]

    assert errors_to_list(changeset) == expected_errors
  end

  test "error on creating second project" do
    owner =
      :user
      |> Factory.insert!()
      |> Projects.exchange_for_owner()

    Factory.insert!(:project, owner_id: owner.id)

    assert {:error, changeset} = Projects.create_project(owner, %{name: "My second project"})

    expected_errors = [owner_id: ["has already been taken"]]

    assert errors_to_list(changeset) == expected_errors
  end

  test "happy path" do
    owner =
      :user
      |> Factory.insert!()
      |> Projects.exchange_for_owner()

    assert {:ok, _project} = Projects.create_project(owner, %{name: "My first project"})
  end
end
