Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)    
    output = @tasks for i in eachindex(x)
                @set reducer = +
                    log(x[i])
             end
             

    return output
end
@ctime foo($x) #hide