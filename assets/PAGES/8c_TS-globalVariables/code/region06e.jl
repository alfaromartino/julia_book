using Random; Random.seed!(1234) # hide
x           = rand(200_000)
const sum_x = sum(x)

function foo(x)
    y    = similar(x)

    for i in eachindex(x)
        y[i] = x[i] / k1
    end

    return y
end
@btime foo($x)    # hide