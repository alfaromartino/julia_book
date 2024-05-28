using Pipe
a = -2

output = @pipe a |> abs |> 2 * _ |> round

#equivalent, but more readable
output = @pipe a            |>
               abs          |>
               2 * _        |>
               round