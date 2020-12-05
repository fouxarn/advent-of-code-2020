defmodule Day05 do
  def readBoardingPasses do
    File.read!("lib/day05input")
    |> String.split("\n")
  end

  def char_to_binary(char) do
    cond do
      char == "F" || char == "L" -> "0"
      char == "B" || char == "R" -> "1"
    end
  end

  def to_binary(pass) do
    String.graphemes(pass) |> Enum.map(&char_to_binary(&1)) |> to_string()
  end

  def to_integer(binaryString) do
    if binaryString == "" do
      0
    else
      String.to_integer(binaryString, 2)
    end
  end

  def calculate_seat_id(pass) do
    {row, column} = String.split_at(pass, -3)

    to_integer(row) * 8 + to_integer(column)
  end

  def part1 do
    readBoardingPasses()
    |> Enum.map(&to_binary/1)
    |> Enum.map(&calculate_seat_id/1)
    |> Enum.max()
    |> IO.inspect()
  end

  def removeFirstConsecutive(t) do
    Enum.reduce(t, [], fn element, acc ->
      case acc do
        [x] when x == element + 1 or x == element - 1 -> [element]
        _ -> [element | acc]
      end
    end)
    |> Enum.reverse()
    |> tl
  end

  def part2 do
    boardingPasses =
      readBoardingPasses()
      |> Enum.map(&to_binary/1)
      |> Enum.map(&String.trim_leading(&1, "0"))

    Enum.to_list(1..1024)
    |> Enum.map(&Integer.to_string(&1, 2))
    |> Enum.filter(fn pass -> !Enum.member?(boardingPasses, pass) end)
    |> Enum.map(&calculate_seat_id/1)
    |> Enum.sort()
    |> removeFirstConsecutive()
    |> hd
    |> IO.puts()
  end
end

Day05.part1()
Day05.part2()
