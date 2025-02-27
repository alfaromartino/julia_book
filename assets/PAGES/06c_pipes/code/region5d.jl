variable_with_a_long_name = 2

output = @pipe variable_with_a_long_name |>
               _ - log(_) / abs(_)