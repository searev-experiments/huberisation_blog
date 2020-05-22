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
    |> strip_unsafe_body(attrs)
  end


  defp strip_unsafe_body(model, %{"body" => nil}) do
    model
  end

  defp strip_unsafe_body(model, %{"body" => body}) do
    {:safe, clean_body} = Phoenix.HTML.html_escape(body)
    model |> put_change(:body, clean_body)
  end

  defp strip_unsafe_body(model, _) do
    model
  end

end
