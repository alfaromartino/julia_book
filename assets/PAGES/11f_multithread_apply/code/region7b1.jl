Random.seed!(1234) #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0
    
    @floop for i in eachindex(x)
        @reduce output += x[i]
    end
    
    return output
end