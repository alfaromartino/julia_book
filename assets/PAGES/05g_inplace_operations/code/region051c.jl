x      = [-2, -1, 1]

slice  = view(x, x .< 0)
slice  = 0                  # this creates a new object, it does NOT modify `x`
print_asis(x) #hide