Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(10_000)
indices = x .> 0.5

function foo(x,indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x,$indices) #hide