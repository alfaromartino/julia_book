Random.seed!(1234) #hide
x = rand(500)

function foo(x)
    output = similar(x)
    
    @batch for i in eachindex(x)
        output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide