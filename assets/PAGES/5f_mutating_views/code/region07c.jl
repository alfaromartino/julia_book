x = zeros(Int64,3)         # `x` is Vector{Int64} with 3 elements equal to zero


for i in eachindex(x)
    x[i] = i
end