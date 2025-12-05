Random.seed!(1234) #hide
x      = rand(1_000_000)

foo(x) = tmap(log, eltype(x), x; chunksize = length(x) ÷ nthreads())
@ctime foo($x) #hide