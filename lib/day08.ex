defmodule Day08 do
  def readInstructions do
    File.read!("lib/day08input")
    |> String.split("\n")
    |> Enum.map(fn instruction ->
      [
        String.slice(instruction, 0..2),
        String.slice(instruction, 4..-1) |> String.to_integer()
      ]
    end)
  end

  def step_instruction(instruction, [counter, acc]) do
    case instruction do
      ["acc", val] -> [counter + 1, acc + val]
      ["jmp", val] -> [counter + val, acc]
      ["nop", _] -> [counter + 1, acc]
    end
  end

  def find_infinite_loop(instructions, [counter, acc] \\ [0, 0], visited \\ []) do
    instruction = Enum.at(instructions, counter)

    if instruction == nil do
      [:ok, acc]
    else
      [counter, acc] = step_instruction(instruction, [counter, acc])

      cond do
        Enum.member?(visited, counter) -> [:error, acc]
        true -> find_infinite_loop(instructions, [counter, acc], [counter | visited])
      end
    end
  end

  def part1 do
    instructions = readInstructions()

    find_infinite_loop(instructions)
    |> IO.inspect()
  end

  def fix_infinite_loop(instructions, [counter, acc] \\ [0, 0], visited \\ []) do
    [cmd, val] = Enum.at(instructions, counter)

    [status, res] =
      case cmd do
        "jmp" ->
          find_infinite_loop(
            List.replace_at(instructions, counter, ["nop", val]),
            [counter, acc],
            visited
          )

        "nop" ->
          find_infinite_loop(
            List.replace_at(instructions, counter, ["jmp", val]),
            [counter, acc],
            visited
          )

        _ ->
          [:error, acc]
      end

    if status == :ok do
      [status, res]
    else
      fix_infinite_loop(instructions, step_instruction([cmd, val], [counter, acc]), [
        counter | visited
      ])
    end
  end

  def part2 do
    instructions = readInstructions()

    fix_infinite_loop(instructions)
    |> IO.inspect()
  end
end

Day08.part1()
Day08.part2()
