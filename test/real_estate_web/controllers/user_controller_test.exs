#require IEx
defmodule RealEstateWeb.UserControllerTest do
  use RealEstateWeb.ConnCase

  alias RealEstate.Account
  alias RealEstate.Account.User

  @create_attrs %{email: "abc@gmail.com", password: "some password"}
  @update_attrs %{email: "some updated email", password: "some updated password"}
  @invalid_attrs %{email: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end


  describe "index" do
    setup [:create_user]
    test "lists all users", %{conn: conn, user: %User{id: _id} = user} do
      # create the token
      {:ok, token, _claims} = RealEstate.Auth.Guardian.encode_and_sign(user)

      # add authorization header to request
      conn = conn |> put_req_header("authorization", "Bearer #{token}")

      response = get(conn, api_v1_user_path(conn, :index))

      # assert %{"success" => true} =
      #   json_response(response, 200)

      assert length(json_response(response, 200)["data"]) > 0
    end 
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post conn, api_v1_registration_path(conn, :create), user: @create_attrs
      #IEx.pry
      assert %{"jwt" => jwt} = json_response(conn, 201)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, api_v1_registration_path(conn, :create), user: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  # describe "update user" do
  #   setup [:create_user]

  #   test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
  #     conn = put conn, user_path(conn, :update, user), user: @update_attrs
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get conn, user_path(conn, :show, id)
  #     assert json_response(conn, 200)["data"] == %{
  #       "id" => id,
  #       "email" => "some updated email",
  #       "password" => "some updated password"}
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, user: user} do
  #     conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete user" do
  #   setup [:create_user]

  #   test "deletes chosen user", %{conn: conn, user: user} do
  #     conn = delete conn, user_path(conn, :delete, user)
  #     assert response(conn, 204)
  #     assert_error_sent 404, fn ->
  #       get conn, user_path(conn, :show, user)
  #     end
  #   end
  # end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
