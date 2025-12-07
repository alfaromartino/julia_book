x                     = [4, 2, -6]

are_elements_positive = ifelse.(x .> 0, true, false)
print_asis(are_elements_positive)       #hide