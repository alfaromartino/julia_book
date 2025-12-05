using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10);   tup = Tuple(x)

function foo(x)
    a = x[1:2]              # 0 allocation (slice of tuple)
    b = (3,4)               # 0 allocation (tuple creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@btime foo(ref($tup)) #hide