defmodule CookpodWeb.Router do
  use CookpodWeb, :router
  use Plug.ErrorHandler

  import Plug.BasicAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # plug :fetch_flash
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :basic_auth, Application.compile_env(:cookpod, :basic_auth)
    plug :put_root_layout, {CookpodWeb.LayoutView, :root}

    # plug(SetLocale,
    #   gettext: CookpodWeb.Gettext,
    #   default_locale: "ru",
    #   cookie_key: "cookpod_locale",
    #   additional_locales: ["ru", "en"]
    # )
  end

  pipeline :protected do
    plug CookpodWeb.AuthPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # scope "/", CookpodWeb do
  #   pipe_through :browser
  #   get "/", PageController, :dummy
  # end

  # scope "/:locale", CookpodWeb do
  scope "/", CookpodWeb do
    pipe_through [:browser]

    get "/", PageController, :index
    get "/hard_work", PageController, :hard_work

    live "/live_test", CookpodLive


    resources "/sessions", SessionController,
      only: [:new, :show, :create, :delete],
      singleton: true

    resources "/users", UserController, only: [:create, :new]

    get "/recipes/drafts", RecipeController, :drafts

    resources "/recipes", RecipeController do
      put "/publish", RecipeController, :publish, as: :publish
      put "/unpublish", RecipeController, :unpublish, as: :unpublish
    end
  end

  # scope "/:locale", CookpodWeb do
  scope "/", CookpodWeb do
    pipe_through [:browser, :protected]

    get "/terms_and_conditions", PageController, :terms_and_conditions
  end

  scope "/api/v1", CookpodWeb.Api, as: :api do
    pipe_through :api

    resources "/recipes", RecipeController
  end

  scope "/api/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :cookpod, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Cookpod"
      },
      basePath: "/api/v1"
    }
  end

  def handle_errors(conn, %{kind: :error, reason: %Phoenix.Router.NoRouteError{}}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_layout({CookpodWeb.LayoutView, :app})
    |> put_view(CookpodWeb.ErrorView)
    |> render("404.html")
  end

  def handle_errors(conn, %{kind: :error, reason: %Phoenix.ActionClauseError{}}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_layout({CookpodWeb.LayoutView, :app})
    |> put_view(CookpodWeb.ErrorView)
    |> render("500.html")
  end

  def handle_errors(conn, _) do
    conn
  end
end