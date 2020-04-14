defmodule HuberisationBlog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :full_name, :string
      add :username, :string
      add :bio, :text
      add :email, :string
      add :password_hash, :string
      add :password_salt, :string
      add :is_admin, :boolean, default: false, null: false

      timestamps()
    end

    alter table(:articles) do
      add :slug, :string
      add :published, :boolean
    end

  end
end
