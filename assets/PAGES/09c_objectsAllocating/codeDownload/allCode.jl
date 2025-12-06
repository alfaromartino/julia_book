############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
    # uncomment if you don't have the package installed
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
 
