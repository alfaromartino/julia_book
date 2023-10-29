x = [-1,2,3] ; using Pipe

output = @pipe abs.(x) |> (_ ./ sum(_)) |> (round.(_))

#equivalent, but more readable
output = @pipe abs.(x)            |>
               _ ./ sum(_)        |>
               round.(_)