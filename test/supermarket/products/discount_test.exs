defmodule Supermarket.Products.DiscountTest do
  use ExUnit.Case

  alias Supermarket.Products.Discount

  describe "Discount struct" do
    test "Creates a product with the given attributes" do
      discount = %Discount{
        code: "D1",
        name: "Discount 1"
      }

      assert discount.code == "D1"
      assert discount.name == "Discount 1"
      assert discount.created_by == nil
      assert discount.type == :buy_one_get_one_free
      assert discount.use_fixed_price == false
      assert discount.fixed_price == 0
      assert discount.is_active == true
      assert discount.is_automatic == false
    end

    test "ensures struct defaults to nil values when not specified" do
      discount = %Discount{}

      assert discount.code == nil
      assert discount.name == nil
      assert discount.created_by == nil
      assert discount.type == :buy_one_get_one_free
      assert discount.use_fixed_price == false
      assert discount.fixed_price == 0
      assert discount.is_active == true
      assert discount.is_automatic == false
    end
  end

  describe "fill/1" do
    test "Should fill values of Discount struct from a map with atom keys" do
      map_with_atoms = %{
        code: "123",
        name: "test"
      }

      assert %Discount{
               code: "123",
               name: "test",
               created_by: nil,
               type: nil,
               use_fixed_price: nil,
               fixed_price: nil,
               is_active: nil,
               is_automatic: nil
             } = Discount.fill(map_with_atoms)
    end

    test "Should fill values of Discount struct from a map with string keys" do
      map_with_atoms = %{
        "code" => "123",
        "name" => "test"
      }

      assert %Discount{
               code: "123",
               name: "test",
               created_by: nil,
               type: nil,
               use_fixed_price: nil,
               fixed_price: nil,
               is_active: nil,
               is_automatic: nil
             } = Discount.fill(map_with_atoms)
    end
  end
end
