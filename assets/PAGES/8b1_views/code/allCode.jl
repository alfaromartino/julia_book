include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using BenchmarkTools, Random, Skipper
 
x = [1, 2, 3]

foo(x) = sum(x[1:2])           # it allocates ONE vector -> the slice 'x[1:2]'

@btime foo(ref($x)) #hide
 
x = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = @views sum(x[x .> 0.5])

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x)) #hide
 
using Skipper
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(skip(≤(0.5), x))

@btime foo(ref($x)) #hide
 
#
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(Iterators.filter(>(0.5), x))

@btime foo(ref($x)) #hide
 
#
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(a for a in x if a > 0.5)

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@btime foo(ref($x)) #hide
 
