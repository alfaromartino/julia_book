include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random
 
############################################################################
#
#                           REDUCTIONS VIA FOR-LOOPS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

foo(x) = sum(x)
 
print_compact(foo(x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output = output + x[i]
    end

    return output
end
 
print_compact(foo(x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x = rand(100)

function foo(x)
    output = 0.0
    
    for i in eachindex(x)
        output += x[i]
    end

    return output
end
 
print_compact(foo(x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#                           OPERATIONS APT FOR REDUCTIONS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(100)

foo1(x) = sum(x)

function foo2(x)
    output = 0.0

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
 
print_compact(foo1(x))
 
print_compact(foo2(x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(100)

foo1(x) = prod(x)

function foo2(x)
    output = 1.0

    for i in eachindex(x)
        output *= x[i]
    end

    return output
end
 
print_compact(foo1(x))
 
print_compact(foo2(x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(100)

foo1(x) = maximum(x)

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, x[i])
    end

    return output
end
 
print_compact(foo1(x))
 
print_compact(foo2(x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(100)

foo1(x) = minimum(x)

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, x[i])
    end

    return output
end
 
print_compact(foo1(x))
 
print_compact(foo2(x))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#                           REDUCTIONS TO AVOID ALLOCATIONS OF INTERMEDIATE RESULTS
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(100)

foo1(x) = sum(log.(x))

function foo2(x)
    output = 0.0

    for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
 
@ctime foo1($x)
 
@ctime foo2($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(100)

foo1(x) = prod(log.(x))

function foo2(x)
    output = 1.0

    for i in eachindex(x)
        output *= log(x[i])
    end

    return output
end
 
@ctime foo1($x)
 
@ctime foo2($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(100)

foo1(x) = maximum(log.(x))

function foo2(x)
    output = -Inf

    for i in eachindex(x)
        output = max(output, log(x[i]))
    end

    return output
end
 
@ctime foo1($x)
 
@ctime foo2($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x       = rand(100)

foo1(x) = minimum(log.(x))

function foo2(x)
    output = Inf
    
    for i in eachindex(x)
        output = min(output, log(x[i]))
    end

    return output
end
 
@ctime foo1($x)
 
@ctime foo2($x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#                           REDUCTIONS VIA BUILT-IN FUNCTIONS
#
############################################################################
 
####################################################
#	SINGLE ARGUMENT
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = sum(log, x)        #same output as sum(log.(x))
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = prod(log, x)       #same output as prod(log.(x))
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = maximum(log, x)    #same output as maximum(log.(x))
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = minimum(log, x)    #same output as minimum(log.(x))
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	SINGLE ARGUMENT and ANONYMOUS FUNCTION
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = sum(a -> 2 * a, x)       #same output as sum(2 .* x)
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = prod(a -> 2 * a, x)      #same output as prod(2 .* x)
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = maximum(a -> 2 * a, x)   #same output as maximum(2 .* x)
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = minimum(a -> 2 * a, x)   #same output as minimum(2 .* x)
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	MULTIPLE ARGUMENTS
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = sum(a -> a[1] * a[2], zip(x,y))         #same output as sum(x .* y)
@ctime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = prod(a -> a[1] * a[2], zip(x,y))        #same output as prod(x .* y)
@ctime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = maximum(a -> a[1] * a[2], zip(x,y))     #same output as maximum(x .* y)
@ctime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = minimum(a -> a[1] * a[2], zip(x,y))     #same output as minimum(x .* y)
@ctime foo($x, $y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#                           REDUCTIONS VIA FUNCTIONS
#
############################################################################
 
####################################################
#	REDUCE
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(+, x)           #same output as sum(x)
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(*, x)           #same output as prod(x)
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(max, x)         #same output as maximum(x)
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(min, x)         #same output as minimum(x)
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	MAP REDUCE WITH A SINGLE ARGUMENT
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(log, +, x)       #same output as sum(log.(x))
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(log, *, x)       #same output as prod(log.(x))
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(log, max, x)     #same output as maximum(log.(x))
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(log, min, x)     #same output as minimum(log.(x))
@ctime foo($x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	MAP REDUCE WITH MULTIPLE ARGUMENTS
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], +, zip(x,y))       #same output as sum(x .* y)
@ctime foo($x,$y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], *, zip(x,y))       #same output as prod(x .* y)
@ctime foo($x,$y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], max, zip(x,y))     #same output as maximum(x .* y)
@ctime foo($x,$y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x        = rand(100)
y        = rand(100)

foo(x,y) = mapreduce(a -> a[1] * a[2], min, zip(x,y))     #same output as minimum(x .* y)
@ctime foo($x,$y) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	REDUCE OR MAPREDUCE
####################################################
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = mapreduce(a -> 2 * a, +, x)
@ctime foo($x)     #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(123)       #setting seed for reproducibility #hide
x      = rand(100)

foo(x) = reduce(+, map(a -> 2 * a, x))
@ctime foo($x)     #hide
 
