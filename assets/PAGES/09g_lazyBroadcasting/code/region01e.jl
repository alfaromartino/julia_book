Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)

function foo(x)
    term1  = x * 2
    
    output = term1 .+ x .*3
end
@ctime foo($x) #hide