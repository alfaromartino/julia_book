using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(10)

@views function foo(x)
    a = x[1:2]              # 0 allocation (view of slice)
    b = [3,4]               # 1 allocation (vector creation) 

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@btime foo(ref($x)) #hide