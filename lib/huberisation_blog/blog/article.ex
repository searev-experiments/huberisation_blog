defmodule HuberisationBlog.Blog.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :content, :string
    field :epigraph, :string
    field :links, {:array, :string}
    field :sources, {:array, :string}
    field :title, :string
    field :vignette, :string
    field :published, :boolean
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title, :epigraph, :content, :sources, :links, :vignette, :published, :slug])
    |> validate_required([:title, :epigraph, :content, :sources, :links, :vignette, :published, :slug])
  end
end
