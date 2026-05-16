Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

function foo(x)
    output = similar(x)   

    for i in eachindex(x)
        output[i] = x[i] * 2
    end

    return output
end
@ctime foo($x) #hide