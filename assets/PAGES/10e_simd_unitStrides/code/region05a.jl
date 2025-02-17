Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x,indices)
    y      = x[indices]
    output = 0.0

    for a in y
        output += a * 0.1 + a^2 * 0.2 - a^3 * 0.3 +  a^4 * 0.4
    end

    return output
end
@ctime foo($x,$indices) #hide