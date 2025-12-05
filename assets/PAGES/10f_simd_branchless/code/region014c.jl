Random.seed!(123)       #setting the seed for reproducibility #hide
x          = rand(1_000_000)
conditions = x .> 0.5

function foo(x)
    output               = similar(x)
    bitvector_conditions = x .> 0.5
    vector_conditions    = Vector(bitvector_conditions)

    for i in eachindex(x)
        output[i] = ifelse(vector_conditions[i], x[i]/i, x[i]*i)
    end

    return output
end
@ctime foo($x) #hide