using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo1(x) = sum(2 .* x)

function foo2(x)
    output = 0.

    for i in eachindex(x)
        output += 2 * x[i]
    end

    return output
end