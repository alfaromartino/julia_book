variable_with_a_long_name = 2 ; using Pipe

output = @pipe variable_with_a_long_name |>
               _ - log(_) / abs(_)