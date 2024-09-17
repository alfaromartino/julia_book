############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# for more accurate results, we perform benchmarks through functions and interpolate each variable.
# this means that benchmarking a function `foo(x)` should be `foo($x)`
using BenchmarkTools
 
# necessary packages for this file
using Random
 
####################################################
#	GENERATORS VS ARRAY COMPREHENSIONS
####################################################
 
x = [a for a in 1:10]

y = [a for a in 1:10 if a > 5]
 



x = (a for a in 1:10)

y = (a for a in 1:10 if a > 5)
 



x = 1:10
 



x = collect(1:10)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    y = [a * 2 for a in x]                  # 1 allocation
    
    sum(y)
end
    
@btime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    y = (a * 2 for a in x)                  # 0 allocations
    
    sum(y)
end
    
@btime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)


foo(x) = sum(a * 2 for a in x)              # 0 allocations
    
@btime foo($x)
 



############################################################################
#
#                           ITERATORS
#
############################################################################

####################################################
#	FILTER
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = collect(1:100)

function foo(x)
    sum(x .> 50)                            # 1 allocation
end
    
@btime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = collect(1:100)

function foo(x)
    y = filter(a -> a > 50, x)              # 1 allocation 

    sum(y)
end
    
@btime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = collect(1:100)

function foo(x)
    y = Iterators.filter(a -> a > 50, x)    # 0 allocations 

    sum(y)
end
    
@btime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = collect(1:100)

function foo(x)
    y = (a for a in x if a > 50)            # 0 allocations

    sum(y)
end
    
@btime foo($x)
 



####################################################
#	MAP
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x) 
    y = map(a -> a * 2, x)                  # 1 allocation

    sum(y)
end
    
@btime foo($x)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    y = Iterators.map(a -> a * 2, x)        # 0 allocations

    sum(y)
end
    
@btime foo($x)
 
