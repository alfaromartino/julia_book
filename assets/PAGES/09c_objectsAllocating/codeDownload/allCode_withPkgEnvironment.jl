####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used on the website.
# It requires having all files in the same folder (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml).

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
############################################################################
#
#			SECTION: "OBJECTS NOT ALLOCATING MEMORY"
#
############################################################################
 
####################################################
#	SINGLE NUMBERS (SCALARS) DON'T CREATE ALLOCATIONS	
####################################################
 
function foo()
    x = 1; y = 2
    
    x + y
end

@ctime foo()
 



####################################################
#	ACCESSING or CREATING TUPLES DON'T CREATE ALLOCATIONS
####################################################
 
function foo()
    tup = (1,2,3)

    tup[1] + tup[2] * tup[3]
end

@ctime foo()
 



####################################################
#	ACCESSING or CREATING NAMED TUPLES DON'T CREATE ALLOCATIONS
####################################################
 
function foo()
    nt = (a=1, b=2, c=3)

    nt.a + nt.b * nt.c
end

@ctime foo()
 



####################################################
#	RANGES DON'T ALLOCATE
####################################################
 
function foo()
    rang = 1:3

    sum(rang[1:2]) + rang[2] * rang[3]
end

@ctime foo()
 



############################################################################
#
#			OBJECTS ALLOCATING MEMORY
#
############################################################################
 
####################################################
#	CREATION OF ARRAYS ALLOCATES
####################################################
 
foo() = [1,2,3]

@ctime foo()
 



foo() = sum([1,2,3])


@ctime foo()
 



####################################################
#	ACCESS TO SLICES ALLOCATES
####################################################
 
x      = [1,2,3]

foo(x) = x[1:2]                 # allocations only from 'x[1:2]' itself (ranges don't allocate)

@ctime foo($x)
 



x      = [1,2,3]

foo(x) = x[[1,2]]               # allocations from both '[1,2]' and 'x[[1,2]]' itself

@ctime foo($x)
 



####################################################
#	ACCESS TO THE WHOLE VECTOR OR SINGLE-ELEMENTS DOESN'T ALLOCATE
####################################################
 
x      = [1,2,3]

foo(x) = 2 * sum(x)             

@ctime foo($x)
 



x      = [1,2,3]

foo(x) = x[1] * x[2] + x[3]

@ctime foo($x)
 



####################################################
#	ARRAY COMPREHENSIONS ALLOCATE
####################################################
 
foo()  = [a for a in 1:3]


@ctime foo()
 



####################################################
#	BROADCASTING ALLOCATES
####################################################
 
x      = [1,2,3]
foo(x) = x .* x

@ctime foo($x)
 



x      = [1,2,3]
foo(x) = sum(x .* x)                # allocations from temporary vector 'x .* x' 

@ctime foo($x)
 
