############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git") #uncomment if you don't have the package installed
using FastBenchmark
    
############################################################################
#   AUXILIARS FOR DISPLAYING RESULTS
############################################################################
# you can alternatively use "println" or "display"
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)


############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Random, Skipper
 
############################################################################
#
#                           GLOBAL VARIABLES
#
############################################################################
 
x = [1, 2, 3]

foo(x) = sum(x[1:2])           # allocations from the slice 'x[1:2]'

@ctime foo($x)
 



x = [1, 2, 3]

foo(x) = sum(@view(x[1:2]))    # it doesn't allocate

@ctime foo($x)
 
####################################################
#	views and boolean index
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

foo(x) = @views sum(x[x .> 0.5])

@ctime foo($x)
 



####################################################
#	skippers for boolean indexing (optional)
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

foo(x) = sum(x[x .> 0.5])

@ctime foo($x)
 



using Skipper
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

foo(x) = sum(skip(≤(0.5), x))

@ctime foo($x)
 



#
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

foo(x) = sum(Iterators.filter(>(0.5), x))

@ctime foo($x)
 



#
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

foo(x) = sum(a for a in x if a > 0.5)

@ctime foo($x)
 
####################################################
#	copying data may be faster
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100_000)

foo(x) = max.(x[1:2:length(x)], 0.5)

@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100_000)

foo(x) = max.(@view(x[1:2:length(x)]), 0.5)

@ctime foo($x)
 
