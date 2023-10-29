x = [-1,2,3]

output = abs.(x) |> (y -> y ./ sum(y)) |> (y -> round.(y))

#equivalent, but more readable
output = abs.(x)                  |>
         y -> y ./ sum(y)         |>
         y -> round.(y)