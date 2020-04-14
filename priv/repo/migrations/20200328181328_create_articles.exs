defmodule HuberisationBlog.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :epigraph, :string
      add :content, :text
      add :sources, {:array, :string}
      add :links, {:array, :string}

      timestamps()
    end

  end
end
