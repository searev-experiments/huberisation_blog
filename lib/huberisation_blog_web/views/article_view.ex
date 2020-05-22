defmodule HuberisationBlogWeb.ArticleView do
  use HuberisationBlogWeb, :view

  def markdown(body) do
    body
    |> Earmark.as_html
    |> get_html
    |> raw
  end

  defp get_html({_, html, _}) do
    html
  end
end
