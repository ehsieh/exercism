defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    Enum.reduce([3,5,7], "", fn i, acc -> acc <> test_factor(number, i) end) |> get_result(number)
  end

  defp test_factor(number, factor) when factor == 3 and rem(number, factor) == 0, do: "Pling"
  defp test_factor(number, factor) when factor == 5 and rem(number, factor) == 0, do: "Plang"
  defp test_factor(number, factor) when factor == 7 and rem(number, factor) == 0, do: "Plong"
  defp test_factor(_, _), do: ""

  defp get_result(result, number) when result == "", do: Integer.to_string(number)
  defp get_result(result, _), do: result
end




