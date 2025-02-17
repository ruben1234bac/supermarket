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

  describe "exist?/1" do
    test "Should return a :ok tuple when the item exist", %{products: products} do
      product = hd(products)
      assert {:ok, product} == ProductManager.exist?(product.code)
    end

    test "Should return a :error tuple when item does not exist" do
      assert {:error, "Item does not exist."} == ProductManager.exist?("TEST")
    end
  end
end
