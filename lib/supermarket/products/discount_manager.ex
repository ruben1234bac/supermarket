defmodule Supermarket.Products.DiscountManager do
  @moduledoc """
  This module handles business logic and operations related to discounts.
  """

  alias Supermarket.Helpers.EtsHelper

  alias Supermarket.Products.{
    Discount,
    ProductDiscount,
    ProductManager
  }

  @table_name :discounts
  @table_name_relation :product_discounts

  @doc """
    Obtain a list of `Discounts`.

    ```elixir
      iex> alias Supermarket.Products.DiscountManager

      iex> DiscountManager.get_all()
      [
        %Supermarket.Products.Discount{
          code: "123",
          name: "test",
          created_by: nil,
          type: :buy_one_get_one_free,
          use_fixed_price: false,
          fixed_price: 0,
          is_active: true,
          is_automatic: false
        }
      ]
    ```
  """
  @spec get_all() :: list(Discount.t())
  def get_all do
    EtsHelper.get_all_items(@table_name)
  end

  @doc """
    Create a new `Discounts` with `:ets`.

    ```elixir
      iex> alias Supermarket.Products.DiscountManager

      iex> DiscountManager.create(%Supermarket.Products.Discount{code: "123", name: "test"})
      {:ok,
        [
          %Supermarket.Products.Discount{
            code: "123",
            name: "test",
            created_by: nil,
            type: :buy_one_get_one_free,
            use_fixed_price: false,
            fixed_price: 0,
            is_active: true,
            is_automatic: false
          }
        ]}
    ```
  """
  @spec create(map()) :: {:ok, list(Discount.t())}
  def create(params) do
    params
    |> Discount.fill()
    |> then(&EtsHelper.add_items(@table_name, [&1]))
  end

  @doc """
    Validate if exist someone `Discount` with a specific `code`.

    ```elixir
      iex> alias Supermarket.Products.DiscountManager

      iex> DiscountManager.exist?("123")
      {:ok,
        %Supermarket.Products.Discount{
          code: "123",
          name: "test",
          created_by: nil,
          type: :buy_one_get_one_free,
          use_fixed_price: false,
          fixed_price: 0,
          is_active: true,
          is_automatic: false
        }
      }

      iex> DiscountManager.exist?("1234")
      {:error, "Item does not exist."}
    ```
  """
  @spec exist?(binary()) :: {:ok, Discount.t()} | {:error, boolean()}
  def exist?(code) do
    EtsHelper.item_exist?(@table_name, code)
  end

  @doc """
    Try to create a relation between product and discount, first to create this relation validate if currently exist the itesm.

    ```elixir
      iex> alias Supermarket.Products.DiscountManager

      iex> DiscountManager.create_product_discount("GR1", "123")
      {:ok,
        [
          %Supermarket.Products.ProductDiscount{
            code: "GR1_123",
            discount_code: "123",
            product_code: "GR1"
          }
        ]
      }

      iex> DiscountManager.exist?("GR1", "1234")
      {:error, "Item does not exist."}
    ```
  """
  @spec create_product_discount(binary(), binary()) ::
          {:ok, ProductDiscount.t()} | {:error, binary()}
  def create_product_discount(product_code, discount_code) do
    with {:ok, _product} <- ProductManager.exist?(product_code),
         {:ok, _discount} <- exist?(discount_code) do
      %{
        code: "#{product_code}_#{discount_code}",
        discount_code: discount_code,
        product_code: product_code
      }
      |> ProductDiscount.fill()
      |> then(&EtsHelper.add_items(@table_name_relation, [&1]))
    end
  end
end
