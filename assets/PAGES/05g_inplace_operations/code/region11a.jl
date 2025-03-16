x          = [-2, -1, 1]

x[x .< 0]  = zeros(length(x[x .< 0]))
print_asis(x) #hide