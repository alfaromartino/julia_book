k3        = 2

foo(x) = [log(x) for _ in 1:100]


@btime foo($k3) # hide