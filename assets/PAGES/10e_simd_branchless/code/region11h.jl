Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        output[i] = (x[i] > 0.5) ? (x[i] / i) : (x[i] * i)
    end

    return output
end
@ctime foo($x) #hide