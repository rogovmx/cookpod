defmodule CookpodWeb.Router do
  use CookpodWeb, :router
  use Plug.ErrorHandler

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BasicAuth, use_config: {:cookpod, :basic_auth}

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

  pipeline :basic_auth do
    plug BasicAuth,
      callback: &MyAppWeb.Protected.Authentication.authenticate/3,
      custom_response: &MyAppWeb.Protected.Helpers.unauthorized_response/1
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

    resources "/sessions", SessionController, except: [:edit], singleton: true
  end  

  # scope "/:locale", CookpodWeb do
  scope "/", CookpodWeb do
    pipe_through [:browser, :protected]

    get "/terms_and_conditions", PageController, :terms_and_conditions
  end  

  def handle_errors(conn, %{kind: :error, reason: %Phoenix.Router.NoRouteError{}}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_layout({CookpodWeb.LayoutView, :session})
    |> put_view(CookpodWeb.ErrorView)
    |> render("404.html")
  end

  def handle_errors(conn, %{kind: :error, reason: %Phoenix.ActionClauseError{}}) do
    conn
    |> fetch_session()
    |> fetch_flash()
    |> put_layout({CookpodWeb.LayoutView, :session})
    |> put_view(CookpodWeb.ErrorView)
    |> render("500.html")
  end

  def handle_errors(conn, _) do
    conn
  end

  # Other scopes may use custom stacks.
  # scope "/api", CookpodWeb do
  #   pipe_through :api
  # end
end
