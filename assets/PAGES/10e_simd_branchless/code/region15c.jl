Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += ifelse((x[i] ≥ 0.99), (log(x[i])), 0)
    end

    return output
end
@ctime foo($x) #hide