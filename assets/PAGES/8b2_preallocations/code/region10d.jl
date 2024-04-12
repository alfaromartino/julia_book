using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x      = rand(100)
output = similar(x)

foo!(output,x) = (@. output = 2 * x)

calling_foo_in_a_loop(output,x) = [sum(foo!(output,x)) for _ in 1:100]

@btime calling_foo_in_a_loop(ref($output),ref($x)) #hide