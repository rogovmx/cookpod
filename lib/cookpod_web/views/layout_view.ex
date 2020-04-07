defmodule CookpodWeb.LayoutView do
  use CookpodWeb, :view

  def new_locale(conn, locale, language_title) do
    "<a href=\"/#{locale}/#{List.delete_at(conn.path_info, 0)}\">#{language_title}</a>" |> raw
    # "<a href=\"#{Routes.page_path(conn, :index, locale)}\">#{language_title}</a>" |> raw
  end

end
