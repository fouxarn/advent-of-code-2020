defmodule Day06 do
  def readCustoms do
    File.read!("lib/day06input")
    |> String.split("\n\n")
  end

  def part1 do
    readCustoms()
    |> Enum.map(
      &(String.replace(&1, "\n", "")
        |> String.graphemes()
        |> Enum.sort()
        |> Enum.dedup()
        |> Enum.count())
    )
    |> Enum.sum()
    |> IO.inspect()
  end

  def included_in_all(group) do
    size = Enum.count(group)

    Enum.join(group)
    |> String.graphemes()
    |> Enum.frequencies()
    |> Enum.filter(fn {_, count} -> count == size end)
    |> Enum.map(fn {q, _} -> q end)
  end

  def part2 do
    readCustoms()
    |> Enum.map(&(String.split(&1, "\n") |> included_in_all))
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
    |> IO.inspect()
  end
end

Day06.part1()
Day06.part2()
