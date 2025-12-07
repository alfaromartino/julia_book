x                     = [4, 2, -6]

x_absolute_value      = ifelse.(x .≥ 0, x, -x)
print_asis(x_absolute_value)       #hide