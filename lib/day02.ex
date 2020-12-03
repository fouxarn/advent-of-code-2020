defmodule Day02 do
  def validatePassword([from, to, letter, password]) do
    occurences = Enum.count(String.graphemes(password), fn x -> x == letter end)
    String.to_integer(from) <= occurences && occurences <= String.to_integer(to)
  end

  def part1 do
    numbers =
      File.read!("lib/day02input")
      |> String.split("\n")
      |> Enum.map(fn x ->
        String.splitter(x, ["-", " ", ":"], trim: true) |> Enum.take(4)
      end)

    Enum.count(numbers, fn x -> validatePassword(x) end) |> IO.puts()
  end

  def validatePassword2([firstIndex, secondIndex, letter, password]) do
    firstValid = String.at(password, String.to_integer(firstIndex) - 1) == letter
    secondValid = String.at(password, String.to_integer(secondIndex) - 1) == letter
    (firstValid && !secondValid) || (!firstValid && secondValid)
  end

  def part2 do
    numbers =
      File.read!("lib/day02input")
      |> String.split("\n")
      |> Enum.map(fn x ->
        String.splitter(x, ["-", " ", ":"], trim: true) |> Enum.take(4)
      end)

    Enum.count(numbers, fn x -> validatePassword2(x) end) |> IO.puts()
  end
end

Day02.part1()
Day02.part2()
