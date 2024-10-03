Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x)                   = sum(log.(x))
calling_foo_in_a_loop(x) = [foo(x) for _ in 1:100]

@btime calling_foo_in_a_loop($x)