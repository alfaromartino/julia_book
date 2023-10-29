using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50);   sx = SVector(x...)

function foo(x; output = Vector{Float64}(undef, length(x)))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end

@btime foo(ref($sx));