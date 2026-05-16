using Random; Random.seed!(1234) #hide
x      = rand(100_000)

foo()  = sum(2 .* x)

@btime foo()    #hide