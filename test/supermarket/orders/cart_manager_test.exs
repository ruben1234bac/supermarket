defmodule Supermarket.Orders.CartManagerTest do
  use ExUnit.Case

  alias Supermarket.Orders.{
    Cart,
    CartManager
  }

  describe "update_cart/2" do
    test "Should create a cart when not exist" do
      assert %Cart{code: "USR1"} == CartManager.update_cart("USR1", [])
    end
  end

  describe "get_cart/1" do
    test "Should get detail of some cart" do
      assert %Cart{code: "USR1"} == CartManager.update_cart("USR1", [])
      assert %Cart{code: "USR1"} == CartManager.get_cart("USR1")
    end

    test "Should get detail of some cart if not exist" do
      assert %Cart{code: "USR1"} == CartManager.get_cart("USR1")
    end
  end
end
