x      = [1,2,3]

foo(x) = x .* x .+ x .* 2 ./ exp.(x)

@btime foo($x) #hide