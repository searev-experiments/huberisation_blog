defmodule HuberisationBlogWeb.PageController do
  use HuberisationBlogWeb, :controller

  alias HuberisationBlog.Blog
  alias HuberisationBlog.Blog.Article

  def index(conn, _params) do
    articles = Blog.list_latest_articles()
    render(conn, "index.html", articles: articles)
  end
end
