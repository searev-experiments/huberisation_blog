defmodule HuberisationBlogWeb.Router do
  use HuberisationBlogWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HuberisationBlogWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/login", SessionController, :new
    post "/login", SessionController, :create
    get "/logout", SessionController, :delete
    get "/register", UserController, :new

    resources "/articles", ArticleController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HuberisationBlogWeb do
  #   pipe_through :api
  # end
end
