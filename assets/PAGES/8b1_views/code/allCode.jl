# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# To print results with a specific format (only relevant for the website)
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x) 
 
 x = [1, 2, 3]

foo(x) = sum(x[1:2])           # it allocates ONE vector -> the slice 'x[1:2]'

@btime foo(ref($x)) 
 
 x = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = @views sum(x[x .> 0.5])

@btime foo(ref($x)) 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@btime foo(ref($x)) 
 
 using Skipper
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(skip(≤(0.5), x))

@btime foo(ref($x)); 
 
 #
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(Iterators.filter(>(0.5), x))

@btime foo(ref($x)); 
 
 #
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(1_000)

foo(x) = sum(a for a in x if a > 0.5)

@btime foo(ref($x)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@btime foo(ref($x)); 
 
 using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@btime foo(ref($x)); 
 
 