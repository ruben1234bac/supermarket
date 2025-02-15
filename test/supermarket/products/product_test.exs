defmodule Supermarket.Products.ProductTest do
  use ExUnit.Case

  alias Supermarket.Products.Product

  describe "Product struct" do
    test "Creates a product with the given attributes" do
      product = %Product{
        code: "GR1",
        name: "Green tea",
        price: 3.11
      }

      assert product.code == "GR1"
      assert product.name == "Green tea"
      assert product.price == 3.11
    end

    test "ensures struct defaults to nil values when not specified" do
      product = %Product{}

      assert product.code == nil
      assert product.name == ""
      assert product.price == 0
      assert product.is_active == true
    end
  end
end
