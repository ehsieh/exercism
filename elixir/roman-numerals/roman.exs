defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    numerals(number, "")
  end

  defp numerals(number, numerals) do
    cond do
      number >= 1000 -> numerals(number - 1000, numerals <> "M")
      number >= 900 -> numerals(number - 900, numerals <> "CM")
      number >= 500 -> numerals(number - 500, numerals <> "D")
      number >= 400 -> numerals(number - 400, numerals <> "CD")
      number >= 100 -> numerals(number - 100, numerals <> "C")
      number >= 90 -> numerals(number - 90, numerals <> "XC")
      number >= 50 -> numerals(number - 50, numerals <> "L")
      number >= 40 -> numerals(number - 40, numerals <> "XL")
      number >= 10 -> numerals(number - 10, numerals <> "X")
      number >= 9 -> numerals(number - 9, numerals <> "IX")
      number >= 5 -> numerals(number - 5, numerals <> "V")
      number >= 4 -> numerals(number - 4, numerals <> "IV")
      number >= 1 -> numerals(number - 1, numerals <> "I")
      number >= 0 -> numerals
    end
  end
  
end
