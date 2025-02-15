defmodule Supermarket.Products.ProductManager do
  @moduledoc """
  This module handles business logic and operations related to products, including their management, validation, and associated rules.
  """

  alias Supermarket.Products.Product

  @doc """
  Obtain a list of `Products`

  ```elixir
    iex> alias Supermarket.Products.ProductManager

    iex> ProductManager.get_all()
    [
      %Supermarket.Products.Product{
        code: "GR1",
        name: "Green tea",
        price: 3.11,
        is_active: true,
        image: ""
      },
      %Supermarket.Products.Product{
        code: "SR1",
        name: "Strawberries",
        price: 5.0,
        is_active: true,
        image: ""
      },
      %Supermarket.Products.Product{
        code: "CF1",
        name: "Coffee",
        price: 11.23,
        is_active: true,
        image: ""
      }
    ]
  ```
  """
  @spec get_all :: list(Product.t())
  def get_all do
    get_product_list()
  end

  defp get_product_list do
    [
      %Product{
        code: "GR1",
        name: "Green tea",
        price: 3.11,
        image: ""
      },
      %Product{
        code: "SR1",
        name: "Strawberries",
        price: 5.00,
        image: ""
      },
      %Product{
        code: "CF1",
        name: "Coffee",
        price: 11.23,
        image: ""
      }
    ]
  end
end
