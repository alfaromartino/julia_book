Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(5_000_000)

function foo(x)
    output  = 0.0

    indices = x .> 0.5
    y       = view(x, indices)

    for i in eachindex(y)
        output += 2 * y[i]
    end

    return output
end
@ctime foo($x) #hide