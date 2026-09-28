Random.seed!(123)       #setting the seed for reproducibility #hide
x         = rand(100)

term1(a)  = a * 2
term2(a)  = a * 3

foo(a)    = term1(a) + term2(a)
@btime foo.($x) #hide