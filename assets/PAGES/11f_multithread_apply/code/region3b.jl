Random.seed!(1234) #hide
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(10_000_000)

function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end