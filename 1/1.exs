# {:ok, pid} = File.open(, [:read])

data =
  File.stream!("./input")
  |> Enum.map(fn s -> String.to_integer(String.trim(s, "\n")) end)
  |> Enum.map(fn x -> floor(x/3) - 2 end)
  |> Enum.sum()

IO.puts(data)
