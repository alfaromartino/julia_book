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
 
#############################          NUMBERS           #########################################
####################################################
#   SINGLE NUMBERS DON'T ALLOCATE	
####################################################
 
function foo()
    x = 1; y = 2
    
    x + y
end

@btime foo()
 


#############################          TUPLES           #########################################
####################################################
#   ACCESSING or CREATING TUPLES DON'T ALLOCATE
####################################################
 
function foo()
    tup = (1,2,3)

    tup[1] + tup[2] * tup[3]
end

@btime foo()
 


####################################################
#   ACCESSING or CREATING NAMED TUPLES DON'T ALLOCATE
####################################################
 
function foo()
    nt = (a=1, b=2, c=3)

    nt.a + nt.b * nt.c
end

@btime foo()
 



function foo()
    rang = 1:3

    rang[1] + rang[2] * rang[3]
end

@btime foo()
 


#############################          ARRAYS           #########################################
####################################################
#	 CREATING ARRAYS ALLOCATE
####################################################
# creating array
 
foo()  = [1,2,3]


@btime foo()
 



foo()  = [a for a in 1:3]


@btime foo()
 



x      = [1,2,3]
foo(x) = x .* x

@btime foo($x)
 


####################################################
#	 ACCESSING ARRAYS ALLOCATE
####################################################
 
x      = [1,2,3]

foo(x) = x[1:2]                 # ONE allocation, since ranges don't allocate (but 'x[1:2]' itself does)

@btime foo($x)
 



x      = [1,2,3]

foo(x) = x[[1,2]]               # TWO allocations (one for '[1,2]' and another for 'x[[1,2]]' itself)

@btime foo($x)
 


####################################################
#	 ACCESSING VECTORS OR SINGLE-ELEMENTS OF ARRAYS DON'T ALLOCATE
####################################################
 
x      = [1,2,3]

foo(x) = 2 * sum(x)             

@btime foo($x)
 



x      = [1,2,3]

foo(x) = x[1] * x[2] + x[3]

@btime foo($x)
 


####################################################
#	 BROADCASTING ALLOCATES - CREATING TEMPORARY VECTORS
####################################################
 
x      = [1,2,3]
foo(x) = sum(x .* x)                # 1 allocation from temporary vector 'x .* x' 

@btime foo($x)
 



x      = [1,2,3]

foo(x) = x .* x .+ x .* 2 ./ exp.(x)

@btime foo($x)
 
