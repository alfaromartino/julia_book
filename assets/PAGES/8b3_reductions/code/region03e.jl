using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo1(x) = all(x .> 0.5)

function foo2(x)
    output = true
    
    for i in eachindex(x)
        output = output && (x[i] > 0.5)
    end

    return output
end