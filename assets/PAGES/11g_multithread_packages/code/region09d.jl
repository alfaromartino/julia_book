Random.seed!(1234) #hide
x = rand(1_000_000)

function foo(x)
    output = 0.0        # any value, to initialize `output`
    
    @floop for i in eachindex(x)
        @reduce output  = +(0.0, log(x[i]))     # 0.0 is the initial value of `output`
    end
    
    return output
end
@ctime foo($x) #hide