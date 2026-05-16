Random.seed!(1234)       #setting seed for reproducibility #hide
x               = rand(1_000_000)

foo(x)          =  mapreduce(log, +, x)
foo_parallel(x) = tmapreduce(log, +, x)