defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.

  :equal
  :unequal
  :sublist
  :superlist
  """
  def compare(a, b) when a === b do
    :equal
  end

  def compare(a, b) when length(a) == length(b) do
    :unequal
  end

  def compare(a, b) when length(a) > length(b) do
    if superlist?(a, b) do
      :superlist
    else
      :unequal
    end
  end

  def compare(a, b) when length(a) < length(b) do
    if sublist?(a, b) do
      :sublist
    else
      :unequal
    end
  end

  defp superlist?(a, b) do
    sublist?(b, a)
  end

  defp sublist?([], _), do: true

  defp sublist?(a, b) do     
    Enum.chunk_every(b, length(a), 1)
    |> Enum.any?(&(&1 === a))
  end
end
