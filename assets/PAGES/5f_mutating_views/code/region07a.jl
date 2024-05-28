x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements


for i in eachindex(x)
    x[i] = i
end