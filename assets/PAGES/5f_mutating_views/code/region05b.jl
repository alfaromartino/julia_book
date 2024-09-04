x  = [-1, -2, 1, 2]

y  = x[x .< 0]              # `y` is a new object
y .= 0                      # this does NOT modify `x`