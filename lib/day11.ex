defmodule Day11 do
  def readSeating do
    File.read!("lib/day11input")
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
  end

  def get_seat(seats, [x, y]) do
    row = get_seat(seats, y)

    if row == nil do
      nil
    else
      get_seat(row, x)
    end
  end

  def get_seat(seats, pos) do
    cond do
      pos < 0 -> nil
      pos >= Enum.count(seats) -> nil
      true -> Enum.at(seats, pos)
    end
  end

  def count_occupied(adjacents) do
    Enum.filter(adjacents, fn seat -> seat == "#" end) |> Enum.count()
  end

  def get_adjacents(seats, [x, y]) do
    xrange = (x - 1)..(x + 1)
    yrange = (y - 1)..(y + 1)

    Enum.flat_map(yrange, fn dy ->
      Enum.map(xrange, fn dx ->
        if dx == x && dy == y, do: nil, else: get_seat(seats, [dx, dy])
      end)
    end)
  end

  def replace_seat(seats, [x, y], val) do
    if val != nil do
      List.update_at(seats, y, fn row -> List.replace_at(row, x, val) end)
    else
      seats
    end
  end

  def handle_seat(seats, pos) do
    occupied = get_adjacents(seats, pos) |> count_occupied()
    seat = get_seat(seats, pos)

    cond do
      seat == "." -> nil
      seat == "#" && occupied < 4 -> nil
      seat == "#" && occupied -> "L"
      seat == "L" && occupied == 0 -> "#"
      true -> nil
    end
  end

  def next_pos(seats, [x, y]) do
    maxX = Enum.count(hd(seats)) - 1
    maxY = Enum.count(seats) - 1

    cond do
      x >= maxX && y >= maxY -> nil
      x >= maxX -> [0, y + 1]
      true -> [x + 1, y]
    end
  end

  def handle_seats(seats, pos \\ [0, 0]) do
    nextSeat = handle_seat(seats, pos)
    nextPos = next_pos(seats, pos)

    if nextPos == nil do
      replace_seat(seats, pos, nextSeat)
    else
      replace_seat(handle_seats(seats, nextPos), pos, nextSeat)
    end
  end

  def find_stable_seating(seats) do
    nextSeating = handle_seats(seats)

    if nextSeating == seats do
      seats
    else
      find_stable_seating(nextSeating)
    end
  end

  def part1 do
    readSeating()
    |> find_stable_seating()
    |> List.flatten()
    |> Enum.filter(fn seat -> seat == "#" end)
    |> Enum.count()
    |> IO.inspect()
  end

  def crawl(seats, [x, y], [dx, dy]) do
    seatpos = [x + dx, y + dy]
    seat = get_seat(seats, seatpos)

    cond do
      seat == nil -> nil
      seat == "." -> crawl(seats, seatpos, [dx, dy])
      true -> seat
    end
  end

  def get_visible(seats, pos) do
    Enum.flat_map(-1..1, fn dy ->
      Enum.map(-1..1, fn dx ->
        if dx == 0 && dy == 0, do: nil, else: crawl(seats, pos, [dx, dy])
      end)
    end)
  end

  def handle_seat2(seats, pos) do
    occupied = get_visible(seats, pos) |> count_occupied()
    seat = get_seat(seats, pos)

    cond do
      seat == "." -> nil
      seat == "#" && occupied < 5 -> nil
      seat == "#" && occupied -> "L"
      seat == "L" && occupied == 0 -> "#"
      true -> nil
    end
  end

  def handle_seats2(seats, pos \\ [0, 0]) do
    nextSeat = handle_seat2(seats, pos)
    nextPos = next_pos(seats, pos)

    if nextPos == nil do
      replace_seat(seats, pos, nextSeat)
    else
      replace_seat(handle_seats2(seats, nextPos), pos, nextSeat)
    end
  end

  def find_stable_seating2(seats) do
    nextSeating = handle_seats2(seats)

    if nextSeating == seats do
      seats
    else
      find_stable_seating2(nextSeating)
    end
  end

  def part2 do
    readSeating()
    |> find_stable_seating2()
    |> List.flatten()
    |> Enum.filter(fn seat -> seat == "#" end)
    |> Enum.count()
    |> IO.inspect()
  end
end

Day11.part1()
Day11.part2()
