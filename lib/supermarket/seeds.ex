defmodule Supermarket.Seeds do
  @moduledoc """
  This module contains logic to storage initial data
  """

  alias Supermarket.Products.DiscountManager

  def init do
    seed_discounts()

    seed_products_discounts()
  end

  defp seed_discounts do
    [
      %{
        code: "2X1",
        created_by: "CEO",
        name: "Buy one get one free",
        type: :buy_one_get_one_free,
        use_fixed_price: false
      },
      %{
        code: "MIN3FIXPRICE",
        created_by: "COO",
        name: "Discount for bulk purchases",
        type: :min_3_fixed_price,
        fixed_price: 4.5,
        use_fixed_price: true
      },
      %{
        code: "MIN3TWOTHIRDS",
        created_by: "CTO",
        name: "Buy 3 or more and price drop to two thirds",
        type: :min_3_two_thirds_price,
        use_fixed_price: false
      }
    ]
    |> Enum.map(&DiscountManager.create/1)
  end

  defp seed_products_discounts do
    [
      {"GR1", "2X1"},
      {"SR1", "MIN3FIXPRICE"},
      {"CF1", "MIN3TWOTHIRDS"}
    ]
    |> Enum.map(fn {products_code, discount_code} ->
      DiscountManager.create_product_discount(products_code, discount_code)
    end)
  end
end
