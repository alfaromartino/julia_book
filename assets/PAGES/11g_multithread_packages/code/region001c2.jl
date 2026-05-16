Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(1_000_000)

foo(x) = tmap(log, eltype(x), x; chunksize = length(x) ÷ nthreads())
@ctime foo($x) #hide