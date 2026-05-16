using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(Bool, 100)

foo1(x) = all(x)

function foo2(x)
    output = true
    
    for i in eachindex(x)
        output = output && x[i]
    end

    return output
end