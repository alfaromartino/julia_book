x  = [1, 2, 3, 4]

y  = view(x, x .≥ 3)
y  = x[x .≥ 3] .* 10    # this creates a new variable 'y'
print_asis(x) #hide