Random.seed!(123)       #setting seed for reproducibility #hide
x   = rand(10)


function foo(x)
    a = x[1:2]              #   allocation (copy of slice)
    b = [3,4]               #   allocation (vector creation)

    sum(a) * sum(b)         # 0 allocation (scalars don't allocate)
end

@ctime foo($x) #hide