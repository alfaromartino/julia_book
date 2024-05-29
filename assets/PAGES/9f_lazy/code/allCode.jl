include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using LazyArrays, Random
 
####################################################
#	GENERATORS VS ARRAY COMPREHENSIONS
####################################################
 
x = [a for a in 1:10]
 
print_asis(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (a for a in 1:10)
 
print_asis(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 1:10
 
print_asis(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = collect(1:10)
 
print_asis(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = [a * 2 for a in x]                  # 1 allocation (same as y = x .* 2)
    
    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = (a * 2 for a in x)                  # 0 allocations
    
    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

foo(x) = sum(a * 2 for a in x)              # 0 allocations
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#                           ITERATORS
#
############################################################################



####################################################
#	FILTER
####################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    sum(x .> 50)                            # 1 allocation
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = filter(a -> a > 50, x)              # 1 allocation 

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = Iterators.filter(a -> a > 50, x)    # 0 allocations 

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = (a for a in x if a > 50)            # 0 allocations

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	MAP
####################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    y = map(a -> a * 2, x)                  # 1 allocation

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = Iterators.map(a -> a * 2, x)        # 0 allocations

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#                           LAZY BROADCASTING
#
############################################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
# broadcasting eager by default
x = rand(100) ; y = rand(100)

foo(x,y) = sum(2 .* x) + sum(2 .* y) / sum(x .* y)

@btime foo($x, $y) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
using LazyArrays
x = rand(100) ; y = rand(100)

foo(x,y) = sum(@~ 2 .* x) + sum(@~ 2 .* y) / sum(@~ x .* y)

@btime foo($x, $y) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx        = @. 4 * x^3 + 3 * x^2 + 2 * x + 1
    ly        = @. 2 * y^3 + 3 * y^2 + 4 * y + 1
    
    
    sum(lx ./ ly)
end

@btime foo($x, $y) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 4 * a^3 + 3 * a^2 + 2 * a + 1
    ly(b)     = 2 * b^3 + 3 * b^2 + 4 * b + 1
    temp(a,b) = lx(a) / ly(b)
    
    sum(Iterators.map(temp, x,y))
end

@btime foo($x, $y) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 4 * a^3 + 3 * a^2 + 2 * a + 1
    ly(b)     = 2 * b^3 + 3 * b^2 + 4 * b + 1
    temp(a,b) = lx(a) / ly(b)
    
    sum(@~ temp.(x,y))
end

@btime foo($x, $y) #hide
 
####################################################
#	CONDITIONS
####################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition1     = x .> 0.25
    condition2     = x .< 0.75    


    sum(condition1 .&& condition2)
end

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition1     = (a > 0.25 for a in x)
    condition2     = (a < 0.75 for a in x)
    all_conditions = ((x && y) for (x,y) in  zip(condition1, condition2))
        
    sum(all_conditions)
end

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition(x) = 0.75 > x > 0.25
    


    sum(@~ condition.(x))
end


@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition1(a)     = a > 0.25
    condition2(a)     = a < 0.75
    all_conditions(a) = condition1(a) && condition2(a)
    
    sum(@~ all_conditions.(x))
end

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    all_conditions    = Iterators.map(a ->  0.25 < a < 0.75 , x)    
    

    sum(all_conditions)
end

@btime foo(ref($x)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    condition1(a)     = a > 0.25
    condition2(a)     = a < 0.75    
    all_conditions    = Iterators.map(a -> condition1(a) && condition2(a) , x)    

    sum(all_conditions)
end

@btime foo(ref($x)) #hide
 
####################################################
#	CONDITIONS
####################################################
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(100)
weights = rand(100) |> (y ->  y ./ sum(y))

temp(x,weights)           = x * weights
weighted_share(x,weights) = sum(temp.(x,weights))

@btime weighted_share(ref($x), ref($weights)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(100)
weights = rand(100) |> (y ->  y ./ sum(y))

temp(x,weights)           = x * weights
weighted_share(x,weights) = sum(Iterators.map(temp, x, weights))

@btime weighted_share(ref($x), ref($weights)) #hide
 
using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x       = rand(100)
weights = rand(100) |> (y ->  y ./ sum(y))

temp(x,weights)           = x * weights
weighted_share(x,weights) = sum(@~ temp.(x,weights))

@btime weighted_share(ref($x), ref($weights)) #hide
 