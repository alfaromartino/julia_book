# to execute the benchmarks
using BenchmarkTools
ref(x) = (Ref(x))[]

# Functions to print result with a specific format (only relevant for the website)
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x) 
 
 ############################################################################
#
#                           GLOBAL VARIABLES
#
############################################################################ 
 
 x = 2

function foo(x) 
    y = 2 * x 
    z = log(y)

    return z
end

# foo(x)  # hide
@code_warntype foo(x)  # type stable 
 
 x = 2

function foo() 
    y = 2 * x 
    z = log(y)

    return z
end

foo()   # hide
@code_warntype foo() # type unstable 
 
 # all operations are type unstable (they're defined in the global scope)
x = 2

y = 2 * x 
z = log(y) 
 
 x  = Vector{Any}(undef, 10)
x .= 1

sum(x)          # hide
@code_warntype sum(x)       # type unstable 
 
 x  = [1, 2, "hello"]    # x has type "Any"


sum(x[1:2])     # hide
@code_warntype sum(x[1:2])  # type unstable 
 
 x  = Vector{Number}(undef, 10)
x .= 1

sum(x)          # hide 
@code_warntype sum(x)       # type unstable 
 
 x  = Vector{Int64}(undef, 10)
x .= 1

sum(x)          # hide
@code_warntype sum(x)       # type stable 
 
 x  = Vector{Float64}(undef, 10)
x .= 1                      # 1 is converted to 1.0 due to x's type 

sum(x)          # hide
@code_warntype sum(x)       # type stable 
 
 x  = [1, 2, 2.5]            # x is converted to Vector{Float64}    


sum(x)          # hide
@code_warntype sum(x)       # type stable 
 
 x  = [1.0, 2, 2.0]          # x is converted to Vector{Float64}


sum(x)          # hide
@code_warntype sum(x)       # type stable 
 
 const a = 5
foo()   = 2 * a

foo()          # hide
@code_warntype foo()        # type stable 
 
 const b = [1, 2, 3]
foo()   = sum(b)

foo()          # hide
@code_warntype foo()        # type stable 
 
 