############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of any function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
# necessary packages for this file
using BenchmarkTools, Random, Skipper
 
x = [1, 2, 3]

foo(x) = sum(x[1:2])           # it allocates ONE vector -> the slice 'x[1:2]'

@btime foo(ref($x))
 

x = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = @views sum(x[x .> 0.5])

@btime foo(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x))
 

using Skipper
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(skip(≤(0.5), x))

@btime foo(ref($x))
 

#
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(Iterators.filter(>(0.5), x))

@btime foo(ref($x))
 

#
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(1_000)

foo(x) = sum(a for a in x if a > 0.5)

@btime foo(ref($x))
 
using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@btime foo(ref($x))
 

using Random; Random.seed!(123)       #setting the seed for reproducibility
x = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@btime foo(ref($x))
 
