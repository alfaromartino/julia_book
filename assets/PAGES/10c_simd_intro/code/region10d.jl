Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] += 2 * x[i]
    end

    return output
end
@ctime foo($x) #hide