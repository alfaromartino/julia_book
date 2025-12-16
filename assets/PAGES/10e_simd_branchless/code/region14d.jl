Random.seed!(123)       #setting the seed for reproducibility #hide
x          = rand(1_000_000)
conditions = x .> 0.5

function foo(conditions,x)
    output           = similar(x)
    

    @inbounds @simd for i in eachindex(x)
        vector_conditions = Int(conditions[i])
        output[i]         = vector_conditions[i] * (x[i] / i) + (1 - vector_conditions[i]) * (x[i] * i)
    end

    return output
end
@ctime foo($conditions,$x) #hide