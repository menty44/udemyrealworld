defmodule UdemyauthWeb.SessionController do
  use UdemyauthWeb, :controller

  alias Udemyauth.Accounts

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn,  %{"user" => %{"email" => "", "password" => ""}})do
      conn
      |> put_flash(:error, "Kindly fill in all the fields")
      |> redirect(to: Routes.session_path(conn, :new))
  end

  def create(conn, %{"user" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_by_email_password(email, password) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back, #{user.name}")
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
        |> redirect(to: "/cms/pages")
      {:error, :unauthorized} ->
        conn
        |> put_flash(:error, "Invalid email or password")
        |> redirect(to: Routes.session_path(conn, :new))
    end

  end

  def delete(conn, _) do
    IO.inspect conn, label: "logout"
    IO.inspect conn, label: "logout"
    IO.inspect conn, label: "logout"
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.session_path(conn, :new))
  end

end
