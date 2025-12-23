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
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Random
 
############################################################################
#
#			GLOBAL VARIABLES
#
############################################################################
 
####################################################
#	When Are We Using Global Variables?
####################################################
 
# all operations are type UNSTABLE (they're defined in the global scope)
x = 2

y = 2 * x 
z = log(y)
 



x = 2

function foo() 
    y = 2 * x 
    z = log(y)

    return z
end

@code_warntype foo() # type UNSTABLE
 



x = 2

function foo(x) 
    y = 2 * x 
    z = log(y)

    return z
end

@code_warntype foo(x)  # type stable
 



############################################################################
#
#			Achieving Type Stability With Global Variables
#
############################################################################
 
####################################################
#	Constant Global Variables
####################################################
 
const a = 5
foo()   = 2 * a

@code_warntype foo()        # type stable
 



const b = [1, 2, 3]
foo()   = sum(b)

@code_warntype foo()        # type stable
 
####################################################
#	warning
####################################################
 
const x1 = 1
foo()    = x1
foo()             # it gives 1

x1       = 2

foo()             # it still gives 1
 



const x2 = 1
foo()    = x2
foo()             # it gives 1

x2       = 2
foo()    = x2
foo()             # it gives 2
 
####################################################
#	Type-Annotating a Global Variable
####################################################
 
x3::Int64           = 5
foo()               = 2 * x3

@code_warntype foo()     # type stable
 
x4::Vector{Float64} = [1, 2, 3]
foo()               = sum(x4)

@code_warntype foo()     # type stable
 
x5::Vector{Number}  = [1, 2, 3]
foo()               = sum(x5)

@code_warntype foo()     # type UNSTABLE
 
############################################################################
#
#			DIFFERENCES BETWEEN APPROACHES
#
############################################################################
 
####################################################
#	differences in code
####################################################
 
x6::Int64 = 5
foo()     = 2 * x6
foo()               # output is 10

x6        = 2
foo()     = 2 * x6
foo()               # output is 4
 
####################################################
#	Differences in Performance
####################################################
 
const k1  = 2

function foo()
    for _ in 1:100_000
       2^k1
    end
end
@ctime foo()
 



k2::Int64 = 2

function foo()
    for _ in 1:100_000
       2^k2
    end
end
@ctime foo()
 



k2::Int64 = 2

function foo()
    for _ in 1:1_000_000
       2^k2
    end
end
@ctime foo()
 



####################################################
#	remark: invariance of operations
####################################################
 
Random.seed!(1234)       #setting seed for reproducibility
x           = rand(100_000)


function foo(x)
    y    = similar(x)
    
    for i in eachindex(x,y)
        y[i] = x[i] / sum(x)
    end

    return y
end
@ctime foo($x)
 



Random.seed!(1234)       #setting seed for reproducibility
x           = rand(100_000)


foo(x) = x ./ sum(x)
@ctime foo($x)
 



Random.seed!(1234)       #setting seed for reproducibility
x           = rand(100_000)
const sum_x = sum(x)

foo(x) = x ./ sum_x
@ctime foo($x)
 
