Random.seed!(1234) # hide
x      = rand(1_000_000)

foo(x) = @tturbo log.(x) ./ x
@ctime foo($x)  # hide