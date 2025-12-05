Random.seed!(1234) #hide
x = rand(250)

function foo(x)
    output = 0.0
    
    @batch reduction=( (+, output) ) for i in eachindex(x)
        output += log(x[i])
    end
    
    return output
end
@ctime foo($x) #hide