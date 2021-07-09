defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when valid, returns a valid changeset" do
      params = %{name: "Leon", email: "leon@beat.com", password: "85675675"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{email: "leon@beat.com", name: "Leon", password: "85675675"},
        errors: []
      } = response
    end

    test "when  there are a invalid, returns a valid changeset" do
      params = %{name: "n", email: "leon@beat.com"}

      response = User.changeset(params)

      expected_response =  %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response

    end
  end

end
