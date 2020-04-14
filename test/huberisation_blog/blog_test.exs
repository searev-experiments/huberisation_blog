defmodule HuberisationBlog.BlogTest do
  use HuberisationBlog.DataCase

  alias HuberisationBlog.Blog

  describe "articles" do
    alias HuberisationBlog.Blog.Article

    @valid_attrs %{content: "some content", epigraph: "some epigraph", links: ["some link"], sources: ["some source"], title: "some title", vignette: "url", slug: "some slug", published: false}
    @update_attrs %{content: "some updated content", epigraph: "some updated epigraph", links: ["some updated link"], sources: ["some updated source"], title: "some updated title", vignette: "some updated url", slug: "some updated slug", published: true}
    @invalid_attrs %{content: nil, epigraph: nil, links: nil, sources: nil, title: nil, vignette: nil, slug: nil, published: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blog.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Blog.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Blog.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Blog.create_article(@valid_attrs)
      assert article.content == "some content"
      assert article.epigraph == "some epigraph"
      assert article.links == ["some link"]
      assert article.sources == ["some source"]
      assert article.title == "some title"
      assert article.vignette == "url"
      assert article.slug == "some slug"
      assert article.published == false
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, %Article{} = article} = Blog.update_article(article, @update_attrs)
      assert article.content == "some updated content"
      assert article.epigraph == "some updated epigraph"
      assert article.links == ["some updated link"]
      assert article.sources == ["some updated source"]
      assert article.title == "some updated title"
      assert article.vignette == "some updated url"
      assert article.slug == "some updated slug"
      assert article.published == true
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_article(article, @invalid_attrs)
      assert article == Blog.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Blog.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Blog.change_article(article)
    end
  end
end
