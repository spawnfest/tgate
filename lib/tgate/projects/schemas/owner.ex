defmodule Tgate.Projects.Schemas.Owner do
  use Ecto.Schema

  alias Tgate.Projects.Schemas.Project

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          project: Project.t() | Ecto.Association.NotLoaded.t()
        }

  schema "users" do
    has_one :project, Project, on_delete: :delete_all
  end
end
