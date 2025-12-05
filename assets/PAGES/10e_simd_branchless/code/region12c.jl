Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)

    @inbounds @simd for i in eachindex(x)
        condition_true  = x[i] > 0.5
        condition_false = 1 - condition_true

        output[i]       = condition_true * (x[i] / i) + condition_false * (x[i] * i)
    end

    return output
end
@ctime foo($x) #hide