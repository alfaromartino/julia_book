Random.seed!(123)       #setting the seed for reproducibility #hide
x          = rand(1_000_000)
conditions = x .> 0.5

function foo(conditions,x)
    output            = similar(x)
    

    @inbounds @simd for i in eachindex(x)
        output[i] = ifelse(conditions[i], (x[i] / i), (x[i] * i))
    end

    return output
end
@ctime foo($conditions,$x) #hide