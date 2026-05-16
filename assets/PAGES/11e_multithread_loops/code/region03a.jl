Random.seed!(1234)       #setting seed for reproducibility #hide
function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end