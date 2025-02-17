defmodule Supermarket.Products.DiscountManagerTest do
  use ExUnit.Case
  use CustomAssert, only: [:assert_list]

  alias Supermarket.Products.{
    Discount,
    DiscountManager,
    ProductDiscount
  }

  alias Supermarket.Helpers.EtsHelper

  @table_name :discounts

  setup do
    discounts = [
      %Discount{
        code: "D1",
        name: "Discount 1"
      },
      %Discount{
        code: "D2",
        name: "Discount 2"
      }
    ]

    {:ok, %{discounts: discounts}}
  end

  describe "get_all/0" do
    test "Should return a list of Discounts", %{discounts: discounts} do
      EtsHelper.add_items(@table_name, discounts)
      assert_list(discounts, DiscountManager.get_all())
    end

    test "Should return an empty list of Discounts" do
      assert [] == DiscountManager.get_all()
    end
  end

  describe "create/1" do
    test "Should create a Discount" do
      assert {:ok, discounts} = DiscountManager.create(%{code: "D1", name: "Discount 1"})
      list = DiscountManager.get_all()
      assert_list(discounts, list)
    end
  end

  describe "exist?/1" do
    test "Should return a :ok tuple when the item exist", %{discounts: discounts} do
      discount = hd(discounts)
      DiscountManager.create(discount)
      assert {:ok, discount} == DiscountManager.exist?(discount.code)
    end

    test "Should return a :error tuple when item does not exist" do
      assert {:error, "Item does not exist."} == DiscountManager.exist?("TEST")
    end
  end

  describe "create_product_discount/2" do
    test "Should create a ProductDiscount when Product and Discount exist", %{
      discounts: discounts
    } do
      product_code = "GR1"
      discount = hd(discounts)
      DiscountManager.create(discount)

      assert {:ok,
              [
                %ProductDiscount{
                  code: "#{product_code}_#{discount.code}",
                  discount_code: discount.code,
                  product_code: product_code
                }
              ]} == DiscountManager.create_product_discount("GR1", discount.code)
    end

    test "Should return an error when discount does not exist" do
      assert {:error, "Item does not exist."} ==
               DiscountManager.create_product_discount("GR1", "TEST")
    end
  end

  describe "get_discount_by_product/1" do
    setup do
      Supermarket.Seeds.init()
    end

    test "Should return a discount related with some product" do
      assert %Discount{
               code: "2X1",
               created_by: "CEO",
               fixed_price: nil,
               is_active: nil,
               is_automatic: nil,
               name: "Buy one get one free",
               type: :buy_one_get_one_free,
               use_fixed_price: false
             } == DiscountManager.get_discount_by_product("GR1")
    end

    test "Should return nil" do
      assert DiscountManager.get_discount_by_product("GR11") == nil
    end
  end
end
