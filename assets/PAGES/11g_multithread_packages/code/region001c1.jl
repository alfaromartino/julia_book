Random.seed!(1234) #hide
x      = rand(1_000_000)

foo(x) = tmap(log, eltype(x), x; nchunks = nthreads())
@ctime foo($x) #hide