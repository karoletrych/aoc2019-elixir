defmodule Sum do
    def sum1(x) do
        max(div(x,3) - 2, 0)
    end

    def sum2(x) do
        sum1(x) |> Stream.iterate(&sum1/1) |> Stream.take_while(&(&1 > 0)) |> Enum.sum();
    end
end


data =
  File.stream!("./input")
  |> Enum.map(fn s -> String.to_integer(String.trim(s, "\n")) end)
#    |> Enum.map(&Sum.sum1/1)
  |> Enum.map(&Sum.sum2/1)
  |> Enum.sum()

IO.puts(data)
