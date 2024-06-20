include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random, LazyArrays
 
####################################################
#	GENERATORS VS ARRAY COMPREHENSIONS
####################################################
 
x = [a for a in 1:10]
 
print_asis(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (a for a in 1:10)
 
print_asis(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 1:10
 
print_asis(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = collect(1:10)
 
print_asis(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = [a * 2 for a in x]                  # 1 allocation (same as y = x .* 2)
    
    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = (a * 2 for a in x)                  # 0 allocations
    
    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)


foo(x) = sum(a * 2 for a in x)              # 0 allocations
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
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
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    sum(x .> 50)                            # 1 allocation
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = filter(a -> a > 50, x)              # 1 allocation 

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = Iterators.filter(a -> a > 50, x)    # 0 allocations 

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = collect(1:100)

function foo(x)
    y = (a for a in x if a > 50)            # 0 allocations

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	MAP
####################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x) 
    y = map(a -> a * 2, x)                  # 1 allocation

    sum(y)
end
    
@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function foo(x)
    y = Iterators.map(a -> a * 2, x)        # 0 allocations

    sum(y)
end
    
@btime foo($x) #hide
 
############################################################################
#
#                           BROADCASTING - LOOP FUSION
#
############################################################################
 
# example 1
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)
β = 1.5

foo(x,β) = exp.(β * x)  + log.(β * x) + (β * x) * 5

@btime foo($x, $β) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)
β = 1.5

foo(x,β) = @. exp(β * x)  + log(β * x) + (β * x) * 5

@btime foo($x, $β) #hide
 
# example 2
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    a = @. 3 * exp(x) + 2 * x
    b = @. 2 * exp(y) + 3 * y
    
    
    a ./ b
end

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y)    




    @. (3 * exp(x) + 2 * x) / (2 * exp(y) + 3 * y)
end

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 3 * exp(a) + 2 * a
    ly(b)     = 2 * exp(b) + 3 * b
    

    @. lx(x) / ly(y)
end

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 3 * exp(a) + 2 * a
    ly(b)     = 2 * exp(b) + 3 * b    
    temp(a,b) = lx(a) / ly(b)

    temp.(x,y)
end

@btime foo($x, $y) #hide
 
############################################################################
#
#                           LAZY BROADCASTING
#
############################################################################
 
Random.seed!(123)       #setting the seed for reproducibility #hide
# eager broadcasting (default)
x = rand(100)

foo(x,y) = sum(2 .* x)

@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
using LazyArrays
x = rand(100)

foo(x,y) = sum(@~ 2 .* x)

@btime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 3 * exp(a) + 2 * a
    ly(b)     = 2 * exp(b) + 3 * b    
    temp(a,b) = lx(a) / ly(b)

    sum(temp.(x,y))   
end

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 3 * exp(a) + 2 * a
    ly(b)     = 2 * exp(b) + 3 * b
    temp(a,b) = lx(a) / ly(b)
    
    sum(Iterators.map(temp, x,y))
end

@btime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100) ; y = rand(100)

function foo(x,y) 
    lx(a)     = 3 * exp(a) + 2 * a
    ly(b)     = 2 * exp(b) + 3 * b
    temp(a,b) = lx(a) / ly(b)
    
    sum(@~ temp.(x,y))
end

@btime foo($x, $y) #hide
 
