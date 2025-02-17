Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
@btime foo($x) #hide