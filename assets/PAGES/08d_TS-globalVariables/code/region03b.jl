k2::Int64 = 2

foo() = [abs(k2) for _ in 1:100]

@btime foo() # hide