defmodule BreadFixed.BreadControllerTest do
  use BreadFixed.ConnCase

  alias BreadFixed.Bread
  @valid_attrs %{fixed: true, name: "baguette"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bread_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    bread = Repo.insert! %Bread{}
    conn = get conn, bread_path(conn, :show, bread)
    assert json_response(conn, 200)["data"] == %{"id" => bread.id,
      "fixed" => bread.fixed}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, bread_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, bread_path(conn, :create), bread: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Bread, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bread_path(conn, :create), bread: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    bread = Repo.insert! %Bread{}
    conn = put conn, bread_path(conn, :update, bread), bread: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Bread, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bread = Repo.insert! %Bread{}
    conn = put conn, bread_path(conn, :update, bread), bread: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    bread = Repo.insert! %Bread{}
    conn = delete conn, bread_path(conn, :delete, bread)
    assert response(conn, 204)
    refute Repo.get(Bread, bread.id)
  end
end
