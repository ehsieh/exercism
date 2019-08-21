defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> String.codepoints
    |> Enum.chunk(3)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&to_protein/1)
    |> Enum.reduce_while([], fn c, acc -> 
          if c != "STOP", do: {:cont, [c | acc]}, else: {:halt, acc} 
       end)
    |> Enum.reverse
    |> of_rna_result
  end  

  defp of_rna_result([]), do: {:error, "invalid RNA"}  
  defp of_rna_result(r) do
    cond do      
      nil in r -> {:error, "invalid RNA"}
      true -> {:ok, r}
    end
  end

  @doc """
  Given a codon, return the corresponding protein  

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case to_protein(codon) do
      nil -> {:error, "invalid codon"}
      "STOP" -> {:ok, "STOP"}
      c -> {:ok, c}
    end
  end

  defp to_protein(codon) do
    cond do
      codon in ["UGU", "UGC"] -> "Cysteine"
      codon in ["UUA", "UUG"] -> "Leucine"
      codon in ["AUG"] -> "Methionine"
      codon in ["UUU", "UUC"] -> "Phenylalanine"
      codon in ["UCU", "UCC","UCA", "UCG"] -> "Serine"
      codon in ["UGG"] -> "Tryptophan"
      codon in ["UAU", "UAC"] -> "Tyrosine"
      codon in ["UAA", "UAG","UGA"] -> "STOP"
      true -> nil      
    end
  end
end
