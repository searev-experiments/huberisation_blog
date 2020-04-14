defmodule HuberisationBlog.Repo.Migrations.UpdateArticleAddVignette do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :vignette, :string
    end
  end
end
