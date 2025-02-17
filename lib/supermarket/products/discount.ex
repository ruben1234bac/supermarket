defmodule Supermarket.Products.Discount do
  @moduledoc """
  This module contain the struct discount
  """
  alias __MODULE__

  @type t :: %__MODULE__{
          code: binary(),
          name: binary(),
          created_by: binary(),
          type: :buy_one_get_one_free | :min_3_fixed_price | :min_3_two_thirds_price,
          use_fixed_price: boolean(),
          fixed_price: 0,
          is_active: boolean(),
          is_automatic: boolean()
        }

  defstruct code: nil,
            name: nil,
            created_by: nil,
            type: :buy_one_get_one_free,
            use_fixed_price: false,
            fixed_price: 0,
            is_active: true,
            is_automatic: false

  @doc """
    Fill a `Discount` struct with a received map.

    ```elixir
      iex> alias Supermarket.Products.Discount

      iex> Discount.fill(%{code: "123", name: "test"})
      %Supermarket.Products.Discount{
        code: "123",
        name: "test",
        created_by: nil,
        type: nil,
        use_fixed_price: nil,
        fixed_price: nil,
        is_active: nil,
        is_automatic: nil
      }
    ```
  """
  @spec fill(map()) :: Discount.t()
  def fill(params) do
    atom_map = Digger.Atomizer.atomize(params)

    %Discount{
      code: Map.get(atom_map, :code),
      name: Map.get(atom_map, :name),
      created_by: Map.get(atom_map, :created_by),
      type: Map.get(atom_map, :type),
      use_fixed_price: Map.get(atom_map, :use_fixed_price),
      fixed_price: Map.get(atom_map, :fixed_price),
      is_active: Map.get(atom_map, :is_active),
      is_automatic: Map.get(atom_map, :is_automatic)
    }
  end
end
