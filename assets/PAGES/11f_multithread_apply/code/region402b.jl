Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(10_000)

function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
foo(x); #hide