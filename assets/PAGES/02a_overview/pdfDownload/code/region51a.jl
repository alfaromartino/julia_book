Random.seed!(1234) # hide
x        = rand(100)

function foo(x)
    a      = x .* 2
    b      = x .* 3
    
    output = a .+ b
end
@btime foo($x)    # hide