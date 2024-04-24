y = [3,4,5]

x = similar(y)                      # `x` has the same type as `y`, which is Vector{Int64}(undef, 3)
print_asis(x) #hide