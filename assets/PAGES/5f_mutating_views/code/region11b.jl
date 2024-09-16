x          = [-1, -2, 3, 4]

x[x .< 0] .= zeros(length(x[x .< 0]))           # identical output
print_asis(x) #hide