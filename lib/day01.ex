defmodule Day01 do
  def testValues(current, numbers) do
    found = Enum.find(numbers, fn y -> current + y == 2020 end)

    if found do
      current * found
    end
  end

  def part1 do
    numbers = File.read!("lib/day01input") |> String.split("\n") |> Enum.map(&String.to_integer/1)

    Enum.find_value(numbers, fn x -> testValues(x, numbers) end)
    |> IO.puts()
  end

  def makestuff(a, b, c) do
    if a + b + c == 2020 do
      a * b * c
    end
  end

  def part2 do
    numbers = File.read!("lib/day01input") |> String.split("\n") |> Enum.map(&String.to_integer/1)

    Enum.find_value(numbers, fn a ->
      Enum.find_value(numbers, fn b ->
        Enum.find_value(numbers, fn c -> makestuff(a, b, c) end)
      end)
    end)
    |> IO.puts()
  end
end

Day01.part1()
Day01.part2()
