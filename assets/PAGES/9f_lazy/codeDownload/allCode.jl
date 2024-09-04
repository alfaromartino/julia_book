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
using Random, LazyArrays
 
####################################################
#	GENERATORS VS ARRAY COMPREHENSIONS
####################################################
 
x = [a for a in 1:10]
 



x = (a for a in 1:10)
 



x = 1:10
 



x = collect(1:10)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100)

function foo(x)
    y = [a * 2 for a in x]                  # 1 allocation (same as y = x .* 2)
    
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
 
############################################################################
#
#                           LAZY BROADCASTING
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility
# broadcasting eager by default
x = rand(100) ; y = rand(100)

foo(x,y) = sum(2 .* x) + sum(2 .* y) / sum(x .* y)

@btime foo($x, $y)
 



Random.seed!(123)       #setting the seed for reproducibility
using LazyArrays
x = rand(100) ; y = rand(100)

foo(x,y) = sum(@~ 2 .* x) + sum(@~ 2 .* y) / sum(@~ x .* y)

@btime foo($x, $y)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx        = @. 4 * x^3 + 3 * x^2 + 2 * x + 1
    ly        = @. 2 * y^3 + 3 * y^2 + 4 * y + 1
    
    
    sum(lx ./ ly)
end

@btime foo($x, $y)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 4 * a^3 + 3 * a^2 + 2 * a + 1
    ly(b)     = 2 * b^3 + 3 * b^2 + 4 * b + 1
    temp(a,b) = lx(a) / ly(b)
    
    sum(Iterators.map(temp, x,y))
end

@btime foo($x, $y)
 



Random.seed!(123)       #setting the seed for reproducibility
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 4 * a^3 + 3 * a^2 + 2 * a + 1
    ly(b)     = 2 * b^3 + 3 * b^2 + 4 * b + 1
    temp(a,b) = lx(a) / ly(b)
    
    sum(@~ temp.(x,y))
end

@btime foo($x, $y)
 
