defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0  
  def count([_|t]) do
    1 + count(t)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end
  defp reverse([], result), do: result
  defp reverse([h|t], result) do
    reverse(t, [h|result])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h|t], f) do
    [f.(h)|map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _), do: []
  def filter([h|t], f) do
    if f.(h) do
      [h|filter(t, f)]
    else
      filter(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h|t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([h|t], b) do
    [h|append(t, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h|t]) do
    append(h, concat(t))
  end
end
