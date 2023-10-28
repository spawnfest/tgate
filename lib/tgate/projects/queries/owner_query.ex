defmodule Tgate.Projects.Queries.OwnerQuery do
  alias Tgate.Accounts.Schemas.User
  alias Tgate.Projects.Schemas.Owner

  @spec exchange(User.t()) :: Owner.t()
  def exchange(%User{id: owner_id}) do
    %Owner{
      id: owner_id
    }
  end
end
