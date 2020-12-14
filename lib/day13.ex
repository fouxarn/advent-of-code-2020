defmodule Day13 do
  def readBusses do
    File.read!("lib/day13input")
    |> String.split("\n")
    |> (fn [timestamp, busses] ->
          [
            String.to_integer(timestamp),
            String.split(busses, ",")
            |> Enum.map(fn businterval ->
              if businterval != "x", do: String.to_integer(businterval), else: businterval
            end)
          ]
        end).()
  end

  def part1 do
    [timestamp, busses] =
      readBusses()
      |> (fn [timestamp, busses] ->
            [timestamp, Enum.filter(busses, fn businterval -> businterval != "x" end)]
          end).()
      |> IO.inspect()

    Enum.map(busses, fn businterval -> businterval - rem(timestamp, businterval) end)
    |> Enum.with_index()
    |> Enum.min_by(fn {val, _} -> val end)
    |> (fn {val, index} -> val * Enum.at(busses, index) end).()
    |> IO.inspect()
  end

  def scan_timestamp([{nextBusInterval, index} | tail], timestamp \\ 0, step \\ 1) do
    if rem(timestamp + index, nextBusInterval) == 0 do
      if tail == [] do
        timestamp
      else
        IO.inspect(binding())
        scan_timestamp(tail, timestamp, step * nextBusInterval)
      end
    else
      scan_timestamp([{nextBusInterval, index} | tail], timestamp + step, step)
    end
  end

  def part2 do
    [_, busses] = readBusses()

    busses
    |> Enum.with_index()
    |> Enum.filter(fn {val, _} -> val != "x" end)
    |> scan_timestamp()
    |> IO.inspect()
  end
end

Day13.part1()
Day13.part2()
