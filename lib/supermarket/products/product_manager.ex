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

  @doc """
    Validate if exist someone `Product` with a specific `code`.

    ```elixir
      iex> alias Supermarket.Products.ProductManager

      iex> ProductManager.exist?("GR1")
      {:ok,
        %Supermarket.Products.Product{
          code: "GR1",
          name: "Green tea",
          price: 3.11,
          is_active: true,
          image: ""
        }
      }

      iex> DiscountManager.exist?("1234")
      {:error, "Item does not exist."}
    ```
  """
  @spec exist?(binary()) :: {:ok, Product.t()} | {:error, boolean()}
  def exist?(code) do
    case Enum.find(get_product_list(), &(&1.code == code)) do
      nil -> {:error, "Item does not exist."}
      item -> {:ok, item}
    end
  end

  defp get_product_list do
    [
      %Product{
        code: "GR1",
        name: "Green tea",
        price: 3.11,
        image: "/images/green_tea.jpg"
      },
      %Product{
        code: "SR1",
        name: "Strawberries",
        price: 5.00,
        image: "/images/strawberries.jpg"
      },
      %Product{
        code: "CF1",
        name: "Coffee",
        price: 11.23,
        image: "/images/coffee.webp"
      }
    ]
  end
end
