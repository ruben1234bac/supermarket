defmodule Supermarket.Products.ProductManagerTest do
  use ExUnit.Case

  alias Supermarket.Products.{
    Product,
    ProductManager
  }

  setup do
    products = [
      %Product{
        code: "GR1",
        name: "Green tea",
        price: 3.11
      },
      %Product{
        code: "SR1",
        name: "Strawberries",
        price: 5.00
      },
      %Product{
        code: "CF1",
        name: "Coffee",
        price: 11.23
      }
    ]

    {:ok, %{products: products}}
  end

  describe "get_all/0" do
    test "Should return a list of Supermarket.Products.Product", %{products: products} do
      assert products == ProductManager.get_all()
    end
  end
end
