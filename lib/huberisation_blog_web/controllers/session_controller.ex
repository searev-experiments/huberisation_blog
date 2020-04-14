defmodule HuberisationBlogWeb.SessionController do
  use HuberisationBlogWeb, :controller

  alias HuberisationBlog.Auth
  alias HuberisationBlog.Auth.User

  def new(conn, _params) do
    changeset = Auth.change_user(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    Auth.get_user_by_username(user_params["username"])
    |> sign_in(user_params["password"], conn)
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp sign_in(user, password, conn) when is_nil(user) do
    conn
    |> put_flash(:error, "Invalid username/password combination!")
    |> redirect(to: Routes.session_path(conn, :new))
  end

  defp sign_in(user, password, conn) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      conn
      |> put_session(:current_user, %{id: user.id, username: user.username})
      |> put_flash(:info, "Logged in!")
      |> redirect(to: Routes.page_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Invalid username/password combination!")
      |> redirect(to: Routes.session_path(conn, :new))
    end
  end

end
