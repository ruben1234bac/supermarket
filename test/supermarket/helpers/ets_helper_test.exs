defmodule Supermarket.Helpers.EtsHelperTest do
  use ExUnit.Case
  use CustomAssert, only: [:assert_list]

  alias Supermarket.Helpers.EtsHelper

  setup do
    {:ok, %{table_name: :test}}
  end

  describe "get_all_items/1" do
    test "Should return an empty list of items when table not exist", %{table_name: table_name} do
      table_name
      |> EtsHelper.get_all_items()
      |> Enum.empty?()
      |> assert
    end

    test "Should return an empty list of items when table exist", %{table_name: table_name} do
      :ets.new(table_name, [:set, :public, :named_table])

      table_name
      |> EtsHelper.get_all_items()
      |> Enum.empty?()
      |> assert
    end

    test "Should return a list of items", %{table_name: table_name} do
      item = %{code: "1234"}
      table = :ets.new(table_name, [:set, :public, :named_table])
      :ets.insert(table, {item.code, item})

      assert EtsHelper.get_all_items(table_name) == [item]
    end
  end

  describe "add_items/2" do
    setup do
      %{items: [%{code: "1"}, %{code: "2"}]}
    end

    test "Should storage a list of items when table not exist", %{
      table_name: table_name,
      items: items
    } do
      assert {:ok, items} == EtsHelper.add_items(table_name, items)
      assert_list(EtsHelper.get_all_items(table_name), items)
    end

    test "Should storage a list of items when table exist", %{
      table_name: table_name,
      items: items
    } do
      :ets.new(table_name, [:set, :public, :named_table])

      assert {:ok, items} == EtsHelper.add_items(table_name, items)
      assert_list(EtsHelper.get_all_items(table_name), items)
    end

    test "Should return an error for not use code as key in each items", %{
      table_name: table_name
    } do
      assert {:error, "Your map or struct should contain code atom key"} ==
               EtsHelper.add_items(table_name, [%{name: "test"}])
    end
  end
end
