defmodule Supermarket.Orders.CartManager do
  @moduledoc """
  This module handles business logic and operations related to cart.
  """

  alias Supermarket.Helpers.{
    DiscountHelper,
    EtsHelper
  }

  alias Supermarket.Orders.Cart

  @table_name :cart

  @doc """
    Update a cart with a list of products, if the cart did not exist, will be created.

    ```elixir
      iex> alias Supermarket.Products.DiscountManager

      iex> DiscountManager.update_cart("USR1", [])
      %Supermarket.Orders.Cart{code: "USR1", products: []}
    ```
  """
  @spec update_cart(binary(), list()) :: Cart.t()
  def update_cart(code, products) do
    with {:ok, [cart]} <- create(%{code: code, products: products}) do
      cart
    end
  end

  @doc """
    Get a cart with a list of products by code, if the cart did not exist, will be created.

    ```elixir
      iex> alias Supermarket.Products.DiscountManager

      iex> DiscountManager.get_cart("USR1")
      %Supermarket.Orders.Cart{code: "USR1", products: []}
    ```
  """
  @spec get_cart(binary()) :: Cart.t()
  def get_cart(code) do
    cart =
      case EtsHelper.item_exist?(@table_name, code) do
        {:ok, cart} ->
          cart

        {:error, _error} ->
          %{code: code}
          |> create()
          |> elem(1)
          |> hd()
      end

    {products, total} = DiscountHelper.build_products(cart.products)
    %{cart | products: products, total: total}
  end

  defp create(params) do
    params
    |> Cart.fill()
    |> then(&EtsHelper.add_items(@table_name, [&1]))
  end
end
