Random.seed!(1234) # hide
x        = rand(100)

foo(x)   = x .* 2 .+ x .* 3     # or @. x * 2 + x * 3
@btime foo($x)    # hide