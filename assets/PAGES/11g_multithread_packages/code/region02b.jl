Random.seed!(1234) #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    foreach(i -> output[i] = log(x[i]), eachindex(x))
        
    

    return output
end
@ctime foo($x) #hide