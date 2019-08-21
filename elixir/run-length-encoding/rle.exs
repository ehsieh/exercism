defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """

  #Map.update(%{a: 1}, :a, 13, &(&1 * 2))
  #%{a: 2}
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string 
    |> String.graphemes
    |> Enum.chunk_by(&(&1))
    |> Enum.reduce("", fn c, acc -> acc <> encode_fragment(List.first(c), length(c)) end)        
  end

  defp encode_fragment(letter, count) when count == 1 do
    letter
  end
  defp encode_fragment(letter, count) do
    Integer.to_string(count) <> letter
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    ~r/(\d+)(.)|(.)/
    |> Regex.scan(string)    
    |> Enum.map(fn n -> expand(n) end)    
    |> Enum.join
  end

  def expand([_, number, letter]) do    
    String.duplicate(letter, String.to_integer(number))
  end  
  def expand([_, _, _, letter]) do    
    letter
  end 
end


