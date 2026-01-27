Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(5_000_000)

indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y) #hide