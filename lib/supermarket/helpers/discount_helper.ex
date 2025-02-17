defmodule Supermarket.Helpers.DiscountHelper do
  @moduledoc """
  This helper contain functions to build and apply discounts to products.
  """

  alias Supermarket.Products.{
    Discount,
    DiscountManager,
    ProductManager
  }

  @doc """
  Receive a list of product codes and build the list of full products with the total of the product list.
  ```elixir
    iex> alias Supermarket.Helpers.DiscountHelper
    iex> DiscountHelper.build_products(["GR1"])
    {[
      %{
        discount: %Supermarket.Products.Discount{
          code: "2X1",
          name: "Buy one get one free",
          created_by: "CEO",
          type: :buy_one_get_one_free,
          use_fixed_price: false,
          fixed_price: 0,
          is_active: true,
          is_automatic: false
        },
        product: %Supermarket.Products.Product{
          code: "GR1",
          name: "Green tea",
          price: 3.11,
          is_active: true,
          image: ""
        },
        quantity: 1,
        total: 3.11
      }
    ], 3.11}
  ```
  """
  @spec build_products(list(binary())) :: {list(), float()}
  def build_products(product_code_list) do
    products =
      product_code_list
      |> Enum.group_by(& &1)
      |> Enum.map(&get_discount/1)

    products
    |> Enum.map(& &1.total)
    |> Enum.sum()
    |> then(&{products, &1})
  end

  defp get_discount({product_code, products}) do
    with {:ok, product} <- ProductManager.exist?(product_code) do
      quantity = length(products)

      {discount, total} =
        product_code
        |> DiscountManager.get_discount_by_product()
        |> apply_discount(quantity, product.price)

      %{
        product: product,
        total: total,
        discount: discount,
        quantity: quantity
      }
    end
  end

  defp apply_discount(%Discount{type: :buy_one_get_one_free} = discount, quantity, price) do
    total =
      if Kernel.rem(quantity, 2) == 0 do
        quantity
        |> Kernel.*(price)
        |> Kernel./(2)
      else
        quantity
        |> Kernel.-(1)
        |> Kernel./(2)
        |> Kernel.*(price)
        |> Kernel.+(price)
      end

    {discount, total}
  end

  defp apply_discount(%Discount{type: :min_3_fixed_price} = discount, quantity, _price)
       when quantity >= 3 do
    {discount, discount.fixed_price * quantity}
  end

  defp apply_discount(%Discount{type: :min_3_two_thirds_price} = discount, quantity, price)
       when quantity >= 3 do
    price
    |> Kernel.*(0.66666)
    |> Kernel.*(quantity)
    |> Float.round(2)
    |> then(&{discount, &1})
  end

  defp apply_discount(_discount, quantity, price), do: {nil, price * quantity}
end
