defmodule Tgate.AccountsTest do
  use Tgate.DataCase, async: true

  alias Tgate.Accounts

  test "error on empty attrs" do
    assert {:error, changeset} = Accounts.register_user(%{})

    expected_errors = Enum.map([:email, :password], fn key -> {key, ["can't be blank"]} end)

    assert errors_to_list(changeset) == expected_errors
  end

  test "error on invalid email" do
    assert {:error, changeset} =
             Accounts.register_user(%{email: "some_invalid", password: "123456"})

    expected_errors = [{:email, ["has invalid format"]}]

    assert errors_to_list(changeset) == expected_errors
  end

  test "error on too small password" do
    assert {:error, changeset} =
             Accounts.register_user(%{email: "test@gmail.com", password: "12345"})

    expected_errors = [{:password, ["should be at least 6 character(s)"]}]

    assert errors_to_list(changeset) == expected_errors
  end

  test "happy path" do
    password = "123456"

    assert {:ok, user} = Accounts.register_user(%{email: "test@gmail.com", password: password})
    assert user.password_hash != password
  end
end
