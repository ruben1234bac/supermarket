defmodule Supermarket.Products.ProductDiscountTest do
  use ExUnit.Case

  alias Supermarket.Products.ProductDiscount

  describe "ProductDiscount struct" do
    test "Creates a product with the given attributes" do
      product_discount = %ProductDiscount{
        code: "TEST",
        discount_code: "1",
        product_code: "2"
      }

      assert product_discount.code == "TEST"
      assert product_discount.discount_code == "1"
      assert product_discount.product_code == "2"
    end

    test "ensures struct defaults to nil values when not specified" do
      product_discount = %ProductDiscount{}

      assert product_discount.code == nil
      assert product_discount.discount_code == nil
      assert product_discount.product_code == nil
    end
  end

  describe "fill/1" do
    test "Should fill values of ProductDiscount struct from a map with atom keys" do
      map_with_atoms = %{
        code: "TEST",
        discount_code: "1",
        product_code: "2"
      }

      assert %ProductDiscount{
               code: "TEST",
               discount_code: "1",
               product_code: "2"
             } = ProductDiscount.fill(map_with_atoms)
    end

    test "Should fill values of ProductDiscount struct from a map with string keys" do
      map_with_atoms = %{
        "code" => "TEST",
        "discount_code" => "1",
        "product_code" => "2"
      }

      assert %ProductDiscount{
               code: "TEST",
               discount_code: "1",
               product_code: "2"
             } = ProductDiscount.fill(map_with_atoms)
    end
  end
end
