Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    output = 0.0
    
    @tturbo for i in eachindex(x)
        output += log(x[i])
    end
    
    return output
end
@ctime foo($x) # hide