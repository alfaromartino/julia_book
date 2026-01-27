Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices) #hide