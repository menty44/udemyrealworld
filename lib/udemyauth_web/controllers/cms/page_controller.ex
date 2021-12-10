defmodule UdemyauthWeb.CMS.PageController do
  use UdemyauthWeb, :controller

  alias Udemyauth.CMS
  alias Udemyauth.CMS.Page

  plug :require_existing_author
  plug :authorize_page when action in [:edit, :update, :delete]

  def index(conn, _params) do
    pages = CMS.list_pages()
    render(conn, "index.html", pages: pages)
  end

  def new(conn, _params) do
    changeset = CMS.change_page(%Page{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"page" => page_params}) do
    case CMS.create_page(conn.assigns.current_author, page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page created successfully.")
        |> redirect(to: Routes.cms_page_path(conn, :show, page))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

 def show(conn, %{"id" => id}) do
  #  page = Udemyauth.CMS.get_page!(id)
  page = id
  |> CMS.get_page!()
  |> CMS.inc_page_views()
  render(conn, "show.html", page: page)
 end

  def edit(conn, _) do
    changeset = Udemyauth.CMS.change_page(conn.assigns.page)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"page" => page_params}) do

    case Udemyauth.CMS.update_page(conn.assigns.page, page_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page updated successfully.")
        |> redirect(to: Routes.cms_page_path(conn, :show, page))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _) do
    {:ok, _page} = Udemyauth.CMS.delete_page(conn.assigns.page)
    conn
    |> put_flash(:info, "Page deleted successfully.")
    |> redirect(to: Routes.cms_page_path(conn, :index))
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
     |> redirect(to: Routes.cms_page_path(conn, :index))
     |> halt()
   end
 end
end
