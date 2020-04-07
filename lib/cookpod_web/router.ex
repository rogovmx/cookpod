defmodule CookpodWeb.Router do
  use CookpodWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    plug(SetLocale,
      gettext: CookpodWeb.Gettext,
      default_locale: "ru",
      cookie_key: "cookpod_locale",
      additional_locales: ["ru", "en"]
    )
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", CookpodWeb do
    pipe_through :browser
    get "/", PageController, :dummy
  end

  scope "/:locale", CookpodWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/terms_and_conditions", PageController, :terms_and_conditions
  end  

  # Other scopes may use custom stacks.
  # scope "/api", CookpodWeb do
  #   pipe_through :api
  # end
end
