defmodule Supermarket.Orders.Cart do
  @moduledoc """
  This module contain the cart struct
  """
  alias __MODULE__

  @type t() :: %__MODULE__{
          code: binary(),
          products: list(binary()),
          total: 0
        }

  defstruct code: nil,
            products: [],
            total: 0

  @doc """
    Fill a `Cart` struct with a received map.

    ```elixir
      iex> alias Supermarket.Orders.Cart

      iex> Discount.fill(%{code: "123", product_code: "GR1"})
      %Supermarket.Orders.Cart{
        code: "123",
        products: [],
        total: 0
      }
    ```
  """
  @spec fill(map()) :: Cart.t()
  def fill(params) do
    atom_map = Digger.Atomizer.atomize(params)

    %Cart{
      code: Map.get(atom_map, :code),
      products: Map.get(atom_map, :products, []),
      total: Map.get(atom_map, :total, 0)
    }
  end
end
