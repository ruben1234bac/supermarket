defmodule Supermarket.Products.ProductDiscount do
  @moduledoc """
  This module contain the struct discount
  """
  alias __MODULE__

  @type t :: %__MODULE__{
          code: binary(),
          discount_code: binary(),
          product_code: binary()
        }

  defstruct code: nil,
            discount_code: nil,
            product_code: nil

  @doc """
    Fill a `ProductDiscount` struct with a received map.

    ```elixir
      iex> alias Supermarket.Products.ProductDiscount

      iex> ProductDiscount.fill(%{code: "12-34", discount_code: "12", product_code: "34"})
      %Supermarket.Products.ProductDiscount{
        code: "12-34",
        discount_code: "12",
        product_code: "34"
      }
    ```
  """
  @spec fill(map()) :: ProductDiscount.t()
  def fill(params) do
    atom_map = Digger.Atomizer.atomize(params)

    %ProductDiscount{
      code: atom_map.code,
      discount_code: atom_map.discount_code,
      product_code: atom_map.product_code
    }
  end
end
