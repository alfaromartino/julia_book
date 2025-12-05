Random.seed!(123)       #setting seed for reproducibility #hide
x         = rand(100)

function foo(x) 
    term1  = x .* 2
    term2  = x .* 3
    
    output = term1 .+ term2
end
@ctime foo($x) #hide