Random.seed!(123)       #setting the seed for reproducibility #hide
x          = rand(1_000_000)
conditions = x .> 0.5

function foo(conditions,x)
    output            = similar(x)
    vector_conditions = Vector(conditions)

    @inbounds @simd for i in eachindex(x)
        condition_true = vector_conditions[i]
        output[i]      = x[i] * i                   # all filled with the value when false

        condition_true && (output[i] = x[i] / i)        
    end

    return output
end
@ctime foo($conditions,$x) #hide