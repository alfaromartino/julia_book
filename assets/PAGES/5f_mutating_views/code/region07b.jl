y = [3, 4, 5]
x = similar(y)            # `x` mimicks the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = i
end