using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo1(x) = maximum(2 .* x)

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, 2 * x[i])
    end

    return output
end