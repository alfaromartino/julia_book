using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo1(x) = prod(3 .* x)

function foo2(x)
    output = 1.

    for i in eachindex(x)
        output *= 3 * x[i]
    end

    return output
end