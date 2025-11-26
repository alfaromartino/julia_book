Random.seed!(123)       #setting the seed for reproducibility #hide
x         = rand(100)

function foo(x) 
    term1  = @~ x .* 2
    term2  = @~ x .* 3
    
    output = term1 .+ term2
end
@btime foo($x) #hide