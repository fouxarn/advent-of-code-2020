defmodule Day10 do
  def readAdapters do
    File.read!("lib/day10input")
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def map_distance([val | tail]) do
    if tail == [] do
      [3]
    else
      distance = hd(tail) - val
      [distance | map_distance(tail)]
    end
  end

  def part1 do
    [0 | readAdapters()]
    |> Enum.sort()
    |> map_distance()
    |> Enum.group_by(fn x -> x end)
    |> Map.values()
    |> Enum.map(&Enum.count/1)
    |> Enum.reduce(fn x, acc -> x * acc end)
    |> IO.inspect()
  end

  def calc_weight(optionalCount) do
    # All possible position except jumps > 3
    case optionalCount do
      1 -> 2
      2 -> 4
      3 -> 7
      4 -> 13
    end
  end

  def part2 do
    [0 | readAdapters()]
    |> Enum.sort()
    |> map_distance()
    |> Enum.chunk_by(fn x -> x end)
    |> Enum.filter(fn chunk -> hd(chunk) != 3 end)
    |> Enum.map(fn chunk -> Enum.count(chunk) - 1 end)
    |> Enum.filter(fn count -> count > 0 end)
    |> Enum.reduce(1, fn optionalCount, acc -> calc_weight(optionalCount) * acc end)
    |> IO.inspect()
  end
end

Day10.part1()
Day10.part2()
