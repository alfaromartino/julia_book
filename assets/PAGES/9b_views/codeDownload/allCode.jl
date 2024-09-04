############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate benchmarks, we interpolate variable `x` as in `foo($x)`
using BenchmarkTools



############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
# necessary packages for this file
using Random, Skipper
 
x = [1, 2, 3]

foo(x) = sum(x[1:2])           # it allocates ONE vector -> the slice 'x[1:2]'

@btime foo($x)
 


x = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate

@btime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = @views sum(x[x .> 0.5])

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo($x)
 


using Skipper
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(skip(≤(0.5), x))

@btime foo($x)
 


#
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(Iterators.filter(>(0.5), x))

@btime foo($x)
 


#
Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(a for a in x if a > 0.5)

@btime foo($x)
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@btime foo($x)
 


Random.seed!(123)       #setting the seed for reproducibility
x = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@btime foo($x)
 
