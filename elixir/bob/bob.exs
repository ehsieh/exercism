defmodule Bob do
  def hey(input) do
    cond do      
      silence?(input) -> "Fine. Be that way!"      
      shouting?(input) and question?(input) -> "Calm down, I know what I'm doing!"  
      shouting?(input) -> "Whoa, chill out!"            
      question?(input) -> "Sure."        
      true -> "Whatever."
    end
  end

  defp silence?(input) do
    String.trim(input) == ""
  end

  defp shouting?(input) do
    (String.upcase(input) != String.downcase(input)) and String.upcase(input) == input
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end
end
