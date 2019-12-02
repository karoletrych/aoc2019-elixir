defmodule Day2 do
  def task1(memory) do
    memory = put_elem(memory, 1, 12)
    memory = put_elem(memory, 2, 2)

    Stream.iterate({true, {memory, 0}}, &performInstruction/1)
    |> Stream.take_while(&continue?/1)
    |> Enum.take(-1)
    |> Enum.at(0)
    |> elem(1)
    |> elem(0)
    |> elem(0)
  end

  def task2(memory, expected) do
    results = for x <- 0..99, y <- 0..99, do: {x, y, getResult(x, y, memory)}

    r =
      results
      |> Enum.find(fn e -> elem(e, 2) == expected end)

    elem(r, 0) * 100 + elem(r, 1)
  end

  def getResult(x, y, memory) do
    memory = put_elem(memory, 1, x)
    memory = put_elem(memory, 2, y)

    Stream.iterate({true, {memory, 0}}, &performInstruction/1)
    |> Stream.take_while(&continue?/1)
    |> Enum.take(-1)
    |> Enum.at(0)
    |> elem(1)
    |> elem(0)
    |> elem(0)
  end

  def continue?({status, _}) do
    status
  end

  def performInstruction({_, {memory, pc}}) do
    case elem(memory, pc) do
      1 ->
        {true,
         {put_elem(
            memory,
            memory |> elem(pc + 3),
            (memory |> elem(elem(memory, pc + 1))) +
              (memory |> elem(elem(memory, pc + 2)))
          ), pc + 4}}

      2 ->
        {true,
         {put_elem(
            memory,
            memory |> elem(pc + 3),
            (memory |> elem(elem(memory, pc + 1))) *
              (memory |> elem(elem(memory, pc + 2)))
          ), pc + 4}}

      99 ->
        {false, memory}
    end
  end
end

str = File.read!("./input")

memory =
  str
  |> String.replace("\r", "")
  |> String.replace("\n", "")
  |> String.split(",")
  |> Enum.map(&String.to_integer/1)
  |> List.to_tuple()

# result = Day2.task1(memory)

result = Day2.task2(memory, 19_690_720)

IO.inspect(result)
