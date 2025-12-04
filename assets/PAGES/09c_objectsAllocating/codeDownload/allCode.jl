############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate results, we benchmark code through functions.
    # We also interpolate each function argument, so that they're taken as local variables.
    # All this means that benchmarking a function `foo(x)` is done via `foo($x)`
using BenchmarkTools

# The following defines the macro `@ctime`, which is equivalent to `@btime` but faster
    # to use it, replace `@btime` with `@ctime`
using Chairmarks
macro ctime(expr)
    esc(quote
        object = @b $expr
        result = sprint(show, "text/plain", object) |>
            x -> object.allocs == 0 ?
                x * " (0 allocations: 0 bytes)" :
                replace(x, "allocs" => "allocations") |>
            x -> replace(x, r",.*$" => ")") |>
            x -> replace(x, "(without a warmup) " => "")
        println("  " * result)
    end)
end

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
#############################          NUMBERS           #########################################
####################################################
#   SINGLE NUMBERS DON'T ALLOCATE	
####################################################
 
function foo()
    x = 1; y = 2
    
    x + y
end

@ctime foo()
 


#############################          TUPLES           #########################################
####################################################
#   ACCESSING or CREATING TUPLES DON'T ALLOCATE
####################################################
 
function foo()
    tup = (1,2,3)

    tup[1] + tup[2] * tup[3]
end

@ctime foo()
 


####################################################
#   ACCESSING or CREATING NAMED TUPLES DON'T ALLOCATE
####################################################
 
function foo()
    nt = (a=1, b=2, c=3)

    nt.a + nt.b * nt.c
end

@ctime foo()
 



function foo()
    rang = 1:3

    sum(rang[1:2]) + rang[2] * rang[3]
end

@ctime foo()
 


#############################          ARRAYS           #########################################
####################################################
#	 CREATING ARRAYS ALLOCATE
####################################################
# creating array
 
foo() = [1,2,3]

@ctime foo()
 



foo() = sum([1,2,3])


@ctime foo()
 



foo()  = [a for a in 1:3]


@ctime foo()
 



x      = [1,2,3]
foo(x) = x .* x

@ctime foo($x)
 


####################################################
#	 ACCESSING ARRAYS ALLOCATE
####################################################
 
x      = [1,2,3]

foo(x) = x[1:2]                 # allocations only from 'x[1:2]' itself (ranges don't allocate)

@ctime foo($x)
 



x      = [1,2,3]

foo(x) = x[[1,2]]               # allocations from both '[1,2]' and 'x[[1,2]]' itself

@ctime foo($x)
 


####################################################
#	 ACCESSING VECTORS OR SINGLE-ELEMENTS OF ARRAYS DON'T ALLOCATE
####################################################
 
x      = [1,2,3]

foo(x) = 2 * sum(x)             

@ctime foo($x)
 



x      = [1,2,3]

foo(x) = x[1] * x[2] + x[3]

@ctime foo($x)
 


####################################################
#	 BROADCASTING ALLOCATES - CREATING TEMPORARY VECTORS
####################################################
 
x      = [1,2,3]
foo(x) = sum(x .* x)                # allocations from temporary vector 'x .* x' 

@ctime foo($x)
 



x      = [1,2,3]

foo(x) = x .* x .+ x .* 2 ./ exp.(x)

@ctime foo($x)
 
