Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        condition_true = x[i] > 0.5
        output[i]      = x[i] * i                   # all filled with the value when false

        condition_true && (output[i] = x[i] / i)
    end

    return output
end
@ctime foo($x)