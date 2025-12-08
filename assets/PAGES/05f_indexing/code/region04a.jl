x            = [3, 6, 8, 100]

# numbers greater than 5, lower than 10, but not including 8

y            = x[(x .> 5) .&& (x .< 10) .&& (x .≠ 8)]