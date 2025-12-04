Random.seed!(123)       #setting the seed for reproducibility #hide
x        = rand(100)

function foo(x)
    a      = x .* 2
    b      = x .* 3
    
    output = a .+ b
end
@ctime foo($x)    #hide