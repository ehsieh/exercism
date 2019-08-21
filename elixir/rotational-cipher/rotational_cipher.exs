defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.
  
  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @alphabet_length 26
  defguard is_alpha(c) when c in ?A..?Z or c in ?a..?z
  defguard is_uppercase_wrap(c, shift) when c in ?A..?Z  and c + shift > ?Z
  defguard is_lowercase_wrap(c, shift) when c in ?a..?z and c + shift > ?z

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    Enum.map(String.to_charlist(text), fn c -> rotate_char(c, shift) end) |> List.to_string
  end  

  def rotate_char(c, shift) when shift == 0 or not is_alpha(c) do
    c
  end

  def rotate_char(c, shift) when is_uppercase_wrap(c, shift) or is_lowercase_wrap(c, shift) do
    c + shift - @alphabet_length
  end

  def rotate_char(c, shift) do
    c + shift
  end

  
end
