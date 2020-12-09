defmodule Day09 do
  def readNumbers do
    File.read!("lib/day09input")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def validate_recursive(numbers) do
    preamble = Enum.slice(numbers, 0..24)
    value = Enum.at(numbers, 25)

    if Enum.any?(preamble, fn x -> Enum.any?(preamble, fn y -> x + y == value && x != y end) end) do
      validate_recursive(tl(numbers))
    else
      value
    end
  end

  def part1 do
    readNumbers()
    |> validate_recursive()
    |> IO.inspect()
  end

  def find_weakness(numbers, target) do
    serie =
      Enum.reduce_while(numbers, [], fn x, acc ->
        if Enum.sum(acc) < target, do: {:cont, [x | acc]}, else: {:halt, acc}
      end)

    if Enum.sum(serie) == target do
      serie
    else
      find_weakness(tl(numbers), target)
    end
  end

  def part2 do
    value =
      readNumbers()
      |> validate_recursive()

    readNumbers()
    |> find_weakness(value)
    |> Enum.min_max()
    |> Tuple.to_list()
    |> Enum.sum()
    |> IO.inspect()
  end
end

Day09.part1()
Day09.part2()
