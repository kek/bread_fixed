defmodule BreadFixed.BreadController do
  use BreadFixed.Web, :controller

  alias BreadFixed.Bread

  plug :scrub_params, "bread" when action in [:create, :update]

  def index(conn, _params) do
    bread = Repo.all(Bread)
    render(conn, "index.json", bread: bread)
  end

  def create(conn, %{"bread" => bread_params}) do
    changeset = Bread.changeset(%Bread{}, bread_params)

    case Repo.insert(changeset) do
      {:ok, bread} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", bread_path(conn, :show, bread))
        |> render("show.json", bread: bread)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(BreadFixed.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bread = Repo.get!(Bread, id)
    render(conn, "show.json", bread: bread)
  end

  def update(conn, %{"id" => id, "bread" => bread_params}) do
    bread = Repo.get!(Bread, id)
    changeset = Bread.changeset(bread, bread_params)
    IO.inspect bread_params

    case Repo.update(changeset) do
      {:ok, bread} ->
        IO.puts changeset.valid?
        render(conn, "show.json", bread: bread)
      {:error, changeset} ->
        IO.puts "NOT OK"
        conn
        |> put_status(:unprocessable_entity)
        |> render(BreadFixed.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bread = Repo.get!(Bread, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bread)

    send_resp(conn, :no_content, "")
  end
end
