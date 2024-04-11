using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(50)

function foo(x; output = similar(x))
    for i in eachindex(x)
        temp      = x .> x[i]
        output[i] = sum(temp)
    end

    return output
end