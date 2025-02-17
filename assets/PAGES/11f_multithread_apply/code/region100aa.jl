Random.seed!(1234) #hide
x = rand(10_000_000)

function foo(x)
    output = similar(x)
    
    @sync for i in eachindex(x)
        @spawn output[i] = log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide