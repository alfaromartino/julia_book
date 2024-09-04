Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

aux1(a) = exp(2 * a)
aux2(a) = (3 * a) * 5

foo(a)  = aux1(a) + aux2(a)
@btime foo.($x) #hide