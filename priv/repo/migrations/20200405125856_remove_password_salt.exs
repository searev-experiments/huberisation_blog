defmodule HuberisationBlog.Repo.Migrations.RemovePasswordSalt do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :password_salt, :string
    end

  end
end
