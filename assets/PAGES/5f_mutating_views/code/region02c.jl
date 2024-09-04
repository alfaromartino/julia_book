x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= x[x .≥ 3] .* 10                 # same operation as 'x[x .≥ 3] = x[x .≥ 3] .* 10'
print_asis(x) #hide