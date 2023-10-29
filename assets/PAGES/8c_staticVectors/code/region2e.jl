using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10);   mx = MVector(x...)

function foo(x)
    a = x[MVector(1,2)]     # 0 allocation (slice of static array)
    b = MVector(3,4)        # 0 allocation (static array creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@btime foo(ref($mx))