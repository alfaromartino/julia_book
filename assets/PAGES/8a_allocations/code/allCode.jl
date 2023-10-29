# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# Functions to print result with a specific format (only relevant for the website)
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x) 
 
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

@btime foo(ref($x)) 
 
 ####################################################
#	 ACCESSING ARRAYS ALLOCATE
#################################################### 
 
 x      = [1,2,3]

foo(x) = x[1:2]                 # ONE allocation, since ranges don't allocates (but 'x[1:2]' itself does)

@btime foo(ref($x)) 
 
  
 
 x      = [1,2,3]

foo(x) = x[[1,2]]               # TWO allocations (one for '[1,2]' and another for 'x[[1,2]]' itself)

@btime foo(ref($x)) 
 
 ####################################################
#	 ACCESSING VECTORS OR SINGLE-ELEMENTS OF ARRAYS DON'T ALLOCATE
#################################################### 
 
 x      = [1,2,3]

foo(x) = 2 * sum(x)             

@btime foo(ref($x)) 
 
 x      = [1,2,3]

foo(x) = x[1] * x[2] + x[3]

@btime foo(ref($x)) 
 
 ####################################################
#	 BROADCASTING ALLOCATES - CREATING TEMPORARY VECTORS
#################################################### 
 
 x      = [1,2,3]
foo(x) = sum(x .* x)                # 1 allocation from temporary vector 'x .* x' 

@btime foo(ref($x)) 
 
 x      = [1,2,3]

foo(x) = x .* x .+ x .* 2 ./ exp.(x)

@btime foo(ref($x)) 
 
 