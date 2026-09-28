Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(x)
    output = 0.0
    
    for i in eachindex(x)
        output += x[i]
    end

    return output
end