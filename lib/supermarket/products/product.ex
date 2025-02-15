defmodule Supermarket.Products.Product do
  @moduledoc """
  This module contain the struct product
  """
  @type t :: %__MODULE__{
          code: binary(),
          name: binary(),
          price: float(),
          image: binary(),
          is_active: boolean()
        }

  defstruct code: nil,
            name: "",
            price: 0,
            is_active: true,
            image: ""
end
