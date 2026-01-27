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
#			SECTION: "CONDITIONAL STATEMENTS"
#
############################################################################
 
############################################################################
#
#			IF-THEN STATEMENTS
#
############################################################################
 
x = 5

if x > 0
    println("x is positive")
end
 



x = 5

(x > 0) && (println("x is positive"))
 



x = 5

(x ≤ 0) || (println("x is positive"))
 



############################################################################
#
#			IF-ELSE STATEMENTS
#
############################################################################
 
x = 5

if x > 0
    println("x is positive")
else
    println("x is not positive")
end
 



x = 5

x > 0 ? println("x is positive") : println("x is not positive")
 



####################################################
#	ifelse function
####################################################
 
x                     = [4, 2, -6]

are_elements_positive = ifelse.(x .> 0, true, false)
println(are_elements_positive)
 



x                     = [4, 2, -6]

x_absolute_value      = ifelse.(x .≥ 0, x, -x)
println(x_absolute_value)
 



############################################################################
#
#			IF-ELSE-IF STATEMENTS
#
############################################################################
 
x = -10

if x > 0
    println("x is positive")
elseif x == 0
    println("x is zero")
end
 



x = -10

if x > 0
    println("x is positive")
elseif x == 0
    println("x is zero")
else
    println("x is negative")
end
 
