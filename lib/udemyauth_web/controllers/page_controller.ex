defmodule UdemyauthWeb.PageController do
  use UdemyauthWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  defp require_existing_author(conn, _) do
    author = Udemyauth.CMS.ensure_author_exists(conn.assigns.current_user)
    assign(conn, :current_author, author)
  end

  defp authorize_page(conn, _) do
    page = Udemyauth.CMS.get_page!(conn.params["id"])
    if conn.assigns.current_author.id === page.author.id do
      assign(conn, :page, page)
    else
      conn
      |> put_flash(:error, "You are not authorized to modify this page.")
      |> redirect(to: cms_page_path(conn, :index))
    end
  end
end
