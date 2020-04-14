defmodule HuberisationBlog.Repo do
  use Ecto.Repo,
    otp_app: :huberisation_blog,
    adapter: Ecto.Adapters.Postgres
end
