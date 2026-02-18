Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(1_000_000)
indices = 1:length(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices) #hide