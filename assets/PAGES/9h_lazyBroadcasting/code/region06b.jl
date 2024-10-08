Random.seed!(1234) # hide
x      = rand(100)

function foo(x)
    output      = similar(x)
    

    for i in eachindex(x)
        output[i] = x[i] / sum(x)
    end

    return output
end
@btime foo($x)    # hide