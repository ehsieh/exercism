defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    words = String.split(sentence, ~r/[ ~!@#$%^&-=_!:]+/, trim: true)
    Enum.reduce words, %{}, fn w, acc ->
      w = String.downcase w
      Map.update acc, w, 1, &(&1 + 1)
    end
  end
end
