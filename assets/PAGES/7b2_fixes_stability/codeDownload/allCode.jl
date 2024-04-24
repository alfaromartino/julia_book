############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of the function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
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
 
const a = 5
foo()   = 2 * a

foo()          # hide
@code_warntype foo()        # type stable
 
const b = [1, 2, 3]
foo()   = sum(b)

foo()          # hide
@code_warntype foo()        # type stable
 
