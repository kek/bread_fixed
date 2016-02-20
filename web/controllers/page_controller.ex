defmodule BreadFixed.PageController do
  use BreadFixed.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
