defmodule HelloPhoenix.PageController do
  use HelloPhoenix.Web, :controller

  plug :action

  def index(conn, _params) do
    conn
    |> put_flash(:info, "Welcome to Phoenix, from a flash notice!")
    |> put_flash(:error, "Let's pretend we have an error.")
    |> assign(:foo, "Foo bar")
    |> render "index.html"
  end
end
