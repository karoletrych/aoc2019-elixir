defmodule Sum do
    def sum1(x) do
        floor(x/3) - 2
    end

    def sum2(x, acc) when x <= 0 do
        acc
    end
    def sum2(x, acc) do
        fuel = sum1(x)
        sum2(fuel, acc + (if fuel <= 0 do 0 else fuel end))
    end
end

# At first, a module of mass 1969 requires 654 fuel.
# Then, this fuel requires 216 more fuel (654 / 3 - 2). 216 then requires 70 more fuel,
# which requires 21 fuel, which requires 5 fuel, which requires no further fuel.
# So, the total fuel required for a module of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966.



data =
  File.stream!("./input")
  |> Enum.map(fn s -> String.to_integer(String.trim(s, "\n")) end)
#   |> Enum.map(&Sum.sum1/1)
  |> Enum.map(&Sum.sum2(&1, 0))
  |> Enum.sum()

IO.puts(data)
