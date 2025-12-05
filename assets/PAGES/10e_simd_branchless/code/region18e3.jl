Random.seed!(123)       #setting the seed for reproducibility #hide
x                = rand(1_000_000)

foo(a) = ifelse(condition_alt(a), branch1(a), branch2(a))

@ctime foo.($x) #hide