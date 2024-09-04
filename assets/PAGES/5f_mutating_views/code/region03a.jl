x          = [1, 2, 3, 4]
x[x .≥ 3] .= x[x .≥ 3] .* 10
print_asis(x) #hide