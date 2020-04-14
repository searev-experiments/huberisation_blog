defmodule HuberisationBlog.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :bio, :string
    field :email, :string
    field :full_name, :string
    field :is_admin, :boolean, default: false
    field :password_hash, :string
    field :username, :string

    # Virtual fields
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(users, attrs) do
    users
    |> cast(attrs, [:full_name, :username, :bio, :email, :password, :is_admin])
    |> validate_required([:full_name, :username, :email, :password])
    |> hash_password
  end

  defp hash_password(changeset) do
    if password = get_change(changeset, :password) do
      changeset
        |> put_change(:password_hash, Bcrypt.hash_pwd_salt(password))
        |> put_change(:password, nil)
    else
      changeset
    end
  end
end
