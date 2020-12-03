defmodule Day03 do
  def step(pos, steps, max) do
    %{pos | :x => Kernel.rem(pos.x + steps, max)}
  end

  def doStepRec(_pos, []) do
    0
  end

  def doStepRec(pos, map) do
    currentRow = hd(map)
    newPos = step(pos, pos[:xStep], String.length(currentRow))

    doStepRec(newPos, Enum.drop(map, pos[:yStep])) +
      if String.at(currentRow, pos[:x]) == "#", do: 1, else: 0
  end

  def part1 do
    map =
      File.read!("lib/day03input")
      |> String.split("\n")

    doStepRec(%{:x => 0, :xStep => 3, :yStep => 1}, map) |> IO.puts()
  end

  def part2 do
    map =
      File.read!("lib/day03input")
      |> String.split("\n")

    (doStepRec(%{:x => 0, :xStep => 1, :yStep => 1}, map) *
       doStepRec(%{:x => 0, :xStep => 3, :yStep => 1}, map) *
       doStepRec(%{:x => 0, :xStep => 5, :yStep => 1}, map) *
       doStepRec(%{:x => 0, :xStep => 7, :yStep => 1}, map) *
       doStepRec(%{:x => 0, :xStep => 1, :yStep => 2}, map))
    |> IO.puts()
  end
end

Day03.part1()
Day03.part2()
