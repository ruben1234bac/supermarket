defmodule Supermarket.Helpers.DiscountHelperTest do
  use ExUnit.Case

  alias Supermarket.Seeds

  alias Supermarket.Helpers.DiscountHelper

  setup do
    Seeds.init()
  end

  describe "build_products/1" do
    for {products, total} <- [
          {["GR1", "SR1", "GR1", "GR1", "CF1"], 22.45},
          {["GR1", "GR1"], 3.11},
          {["SR1", "SR1", "GR1", "SR1"], 16.61},
          {["GR1", "CF1", "SR1", "CF1", "CF1"], 30.57}
        ] do
      test "Should return a list of product with total #{total} and this list of products #{inspect(products)}" do
        products = unquote(products)
        total = unquote(total)

        {_products_result, total_result} = DiscountHelper.build_products(products)

        assert total_result == total
      end
    end
  end
end
