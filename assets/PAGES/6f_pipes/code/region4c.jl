a = -2

output = a |> abs |> (x -> 2 * x) |> round

#equivalent, but more readable
output = a              |>
         abs            |>
         x -> 2 * x     |>
         round