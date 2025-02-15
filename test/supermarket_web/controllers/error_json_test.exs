defmodule SupermarketWeb.ErrorJSONTest do
  use SupermarketWeb.ConnCase, async: true

  test "renders 404" do
    assert SupermarketWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert SupermarketWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
