defmodule Supermarket.Helpers.EtsHelper do
  @moduledoc """
  This helper contain functions to manage easier the `:ets` interaction.
  """

  @doc """
  Obtain a list of map or struct that is storage in the `:ets` with the table name as atom.
  If no table with this name exists, this table will be created.

  ```elixir
    iex> alias Supermarket.Helpers.EtsHelper

    iex> EtsHelper.get_all_items(:table_name)
    []
  ```
  """
  @spec get_all_items(atom() | :ets.tid()) :: list()
  def get_all_items(table_name) do
    table_name
    |> validate_table()
    |> :ets.tab2list()
    |> clean_items
  end

  @doc """
  Storage new elements into the table name received. All items should to have a code parameter.
  If no table with this name exists, this table will be created.


  ```elixir
    iex> alias Supermarket.Helpers.EtsHelper

    iex> EtsHelper.add_items(:table_name, [%{code: "1"}])
    {:ok, [%{code: "1"}]}

    iex> EtsHelper.add_items(:table_name, [%{name: "test"}])
    {:error, "Your map or struct should contain code atom key"}
  ```
  """
  @spec add_items(atom() | :ets.tid(), list()) :: {:ok, list()} | {:error, binary()}
  def add_items(table_name, items) do
    with {:ok, full_items} <- prepare_items(items) do
      table_name
      |> validate_table()
      |> :ets.insert(full_items)

      {:ok, items}
    end
  end

  defp clean_items(item_list) do
    Enum.map(item_list, &Kernel.elem(&1, 1))
  end

  defp prepare_items(items) do
    if Enum.all?(items, &Map.has_key?(&1, :code)) do
      {:ok, Enum.map(items, &{&1.code, &1})}
    else
      {:error, "Your map or struct should contain code atom key"}
    end
  end

  defp validate_table(table_name) do
    if Kernel.!=(:ets.info(table_name), :undefined),
      do: table_name,
      else: :ets.new(table_name, [:set, :public, :named_table])
  end
end
