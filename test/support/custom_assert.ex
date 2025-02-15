defmodule CustomAssert do
  @moduledoc """
  This module is an extension to `asserts` that could be to use in test
  """

  alias __MODULE__

  defmacro __using__(opts) do
    quote do
      @except unquote(Keyword.get(opts, :except, []))
      @only unquote(
              Keyword.get(opts, :only, [
                :assert_list
              ])
            )

      @generated_functions @only -- @except

      if :assert_list in @generated_functions do
        CustomAssert.generate_assert_list()
      end
    end
  end

  defmacro generate_assert_list do
    quote do
      @doc """
      This function compares two lists, either ordered or unordered, and validates that they contain the same elements.
      It normalizes the elements (including maps, if present) before comparison to ensure consistency. If the lists match,
      the assertion passes; otherwise, it raises an error with a detailed message showing the expected and current values.

      """
      @spec assert_list(list(), list()) :: true | no_return()
      def assert_list(first_list \\ [], second_list \\ [])

      def assert_list(first_list, second_list) do
        CustomAssert.do_assert_list(first_list, second_list)
      end

      defoverridable assert_list: 0, assert_list: 1, assert_list: 2
    end
  end

  def do_assert_list(first_list, second_list) do
    first_list_normalized =
      first_list
      |> normalize()
      |> MapSet.new()

    second_list_normalized =
      second_list
      |> normalize()
      |> MapSet.new()

    ExUnit.Assertions.assert(
      first_list_normalized == second_list_normalized,
      """
      Lists do not match:
      Expected: #{inspect(first_list_normalized)}
      Current: #{inspect(second_list_normalized)}
      """
    )
  end

  defp normalize(data) when is_list(data) do
    Enum.map(data, &normalize_value/1)
  end

  defp normalize(_data), do: []

  defp normalize_value(map) when is_map(map) do
    map
    |> Enum.sort()
    |> Enum.into(%{})
  end

  defp normalize_value(value), do: value
end
