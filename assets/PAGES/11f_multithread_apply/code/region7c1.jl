Random.seed!(1234) #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0
    
    @batch reduction=( (+, output) ) for i in eachindex(x)
        output += x[i]
    end
    
    return output
end