defmodule Tgate.Factory do
  alias Tgate.Repo

  # Factories

  def utc_now do
    NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
  end

  def build(:user) do
    %Tgate.Accounts.Schemas.User{
      email: "test_user_#{System.unique_integer()}@gmail.com",
      password: nil,
      password_hash: Argon2.hash_pwd_salt("123456"),
      inserted_at: utc_now(),
      updated_at: utc_now()
    }
  end

  def build(:project) do
    %Tgate.Projects.Schemas.Project{
      name: "test_name_#{System.unique_integer()}",
      owner_id: 0,
      inserted_at: utc_now(),
      updated_at: utc_now()
    }
  end

  # Convenience API

  def build(factory_name, attributes) do
    factory_name |> build() |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name |> build(attributes) |> Repo.insert!()
  end
end
