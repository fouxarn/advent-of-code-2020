defmodule Day07 do
  # def parseRule(rule) do
  #   case rule do
  #     [number, a, b] ->
  #       %{(a <> b) => String.to_integer(number)}

  #     [number, a, b | tail] ->
  #       Map.merge(%{(a <> b) => String.to_integer(number)}, parseRule(tail))

  #     ["no", "other"] ->
  #       %{}
  #   end
  # end

  def parseRule(rule) do
    case rule do
      [count, a, b] ->
        [count, a <> b]

      [count, a, b | tail] ->
        [count, a <> b] ++ parseRule(tail)

      [] ->
        nil
    end
  end

  def readRules do
    File.read!("lib/day07input")
    |> String.split("\n")
    |> Enum.map(
      &(String.split(&1, " ")
        |> Enum.filter(fn x ->
          !String.starts_with?(x, "bag") && x != "contain" && x != "no" && x != "other"
        end)
        |> (fn [a, b | tail] -> [a <> b] ++ parseRule(tail) end).())
    )
    |> Map.new(fn [k | tail] -> {k, tail} end)
  end

  def shinygold_deep(x, _) when x == [] or x == nil do
    false
  end

  def shinygold_deep([_, key | tail], rules) do
    key == "shinygold" || rules[key] |> shinygold_deep(rules) || shinygold_deep(tail, rules)
  end

  def part1 do
    rules = readRules()

    rules
    |> Map.values()
    |> Enum.map(&shinygold_deep(&1, rules))
    |> Enum.filter(fn x -> x end)
    |> Enum.count()
    |> IO.inspect()
  end

  def sum_bags_deep(x, _) when x == [] or x == nil do
    0
  end

  def sum_bags_deep([count, key | tail], rules) do
    countInt = String.to_integer(count)

    countInt + countInt * (rules[key] |> sum_bags_deep(rules)) +
      sum_bags_deep(tail, rules)
  end

  def part2 do
    rules = readRules()

    rules["shinygold"] |> sum_bags_deep(rules) |> IO.inspect()
  end
end

Day07.part1()
Day07.part2()
