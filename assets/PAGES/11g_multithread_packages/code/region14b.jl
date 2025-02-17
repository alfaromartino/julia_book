Random.seed!(1234) # hide
x = rand(1_000)

function foo(x)
    output1 = 1.0
    output2 = 0.0
    
    @floop for i in eachindex(x)
        @reduce output1 *= log(x[i])
        @reduce output2 += log(x[i])
    end
    
    return output1, output2
end
@ctime foo($x)  # hide