defmodule Day04 do
  @requiredKeys [
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid"
    # "cid"
  ]

  def readPassports do
    File.read!("lib/day04input")
    |> String.split("\n\n")
    |> Enum.map(
      &(String.splitter(&1, [" ", "\n"], trim: true)
        |> Enum.to_list())
    )
    |> Enum.map(&entries(&1))
  end

  def entries(fields) when is_list(fields) do
    Enum.map(fields, &String.split(&1, ":"))
  end

  def validateRequiredKeys(passport) do
    keys = Enum.map(passport, fn entry -> hd(entry) end)
    Enum.all?(@requiredKeys, &(&1 in keys))
  end

  def part1 do
    readPassports()
    |> Enum.count(&validateRequiredKeys(&1))
    |> IO.puts()
  end

  def validateField(["byr", value]) do
    val = String.to_integer(value)
    val >= 1920 && val <= 2002
  end

  def validateField(["iyr", value]) do
    val = String.to_integer(value)
    val >= 2010 && val <= 2020
  end

  def validateField(["eyr", value]) do
    val = String.to_integer(value)
    val >= 2020 && val <= 2030
  end

  def validateField(["hgt", value]) do
    cond do
      String.ends_with?(value, "cm") ->
        val = String.slice(value, 0..-3) |> String.to_integer()
        val >= 150 && val <= 193

      String.ends_with?(value, "in") ->
        val = String.slice(value, 0..-3) |> String.to_integer()
        val >= 59 && val <= 76

      true ->
        false
    end
  end

  def validateField(["hcl", value]) do
    String.match?(value, ~r/^#[0-9a-f]{6}$/)
  end

  def validateField(["ecl", value]) do
    Enum.member?(["amb", "blu", "brn", "gry", "grn", "hzl", "oth"], value)
  end

  def validateField(["pid", value]) do
    String.match?(value, ~r/^[0-9]{9}$/)
  end

  def validateField([_, _]) do
    true
  end

  def part2 do
    readPassports()
    |> Enum.filter(&validateRequiredKeys(&1))
    |> Enum.count(fn passport -> Enum.all?(passport, &validateField(&1)) end)
    |> IO.puts()
  end
end

Day04.part1()
Day04.part2()
