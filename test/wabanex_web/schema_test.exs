defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create
  describe "users querys" do
    test "when a valid id i given, returns the user", %{conn: conn} do
      params = %{email: "rafarafa@gmail.com", name: "rafae", password: "1234566"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email

          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

        expected_response =  %{
          "data" => %{
            "getUser" => %{
              "email" => "rafarafa@gmail.com",
              "name" => "rafae"
            }
          }
        }

      assert response == expected_response
    end
  end
end
