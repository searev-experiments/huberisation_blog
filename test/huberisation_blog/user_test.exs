defmodule HuberisationBlog.AuthTest do
  use HuberisationBlog.DataCase

  alias HuberisationBlog.Auth
  alias Bcrypt

  describe "users" do
    alias HuberisationBlog.Auth.User

    @valid_attrs %{bio: "some content", email: "jdoe@acme.org", full_name: "john doe", is_admin: false, password: "password", username: "jdoe"}
    @update_attrs %{bio: "some updated content", email: "jsmith@acme.org", full_name: "john smith", is_admin: true, password: "updated password", username: "jsmith"}
    @invalid_attrs %{bio: nil, email: nil, full_name: nil, is_admin: nil, password_hash: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Auth.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Auth.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      assert user.bio == "some content"
      assert user.email == "jdoe@acme.org"
      assert user.full_name == "john doe"
      assert user.is_admin == false
      assert user.username == "jdoe"

      assert Bcrypt.verify_pass("password", user.password_hash)

    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Auth.update_user(user, @update_attrs)
      assert user.bio == "some updated content"
      assert user.email == "jsmith@acme.org"
      assert user.full_name == "john smith"
      assert user.is_admin == true
      assert user.username == "jsmith"

      assert Bcrypt.verify_pass("updated password", user.password_hash)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert user == Auth.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end

  end
end
