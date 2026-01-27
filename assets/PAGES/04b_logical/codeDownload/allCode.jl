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
#			SECTION: "CONDITIONS"
#
############################################################################
 
####################################################
#	example
####################################################
 
x = 2

#`y` equals `true` or `false`
y = (x > 0)
 
println(y)
 



x = 2

#'z' element equals 'true' or 'false', represented by 1 or 0
z = [x > 0, x < 0]
 
println(z)
 



####################################################
#	comparison operators
####################################################
 
==(1,2)     # same as 1 == 2
 ≠(1,2)     # same as 1 ≠ 2
 ≥(1,2)     # same as 1 ≥ 2
>=(1,2)     # same as 1 ≥ 2
 >(1,2)     # same as 1 > 2
 



############################################################################
#
#			LOGICAL OPERATORS
#
############################################################################
 
x = 2
y = 3

# are both variables positive?
z1 = (x > 0) && (y > 0)

# is either `x` or `y` (or both) positive? 
z2 = (x > 0) || (y > 0)
 
println(z1)
 
println(z2)
 



x = 2

# is `x` positive?
y1 = (x > 0)

# is `x` not lower than zero nor equal to zero? (equivalent)
y2 = !(x ≤ 0)
 
println(y1)
 
println(y2)
 



####################################################
#	Logical Operators as Short-Circuit Operators
####################################################
 
x = 10
 
println((x < 0) && (this-is-not-even-legitimate-code))
 
#println((x > 0) && (this-is-not-even-legitimate-code)) #ERROR
 



x = 10
 
println((x > 0) || (this-is-not-even-legitimate-code))
 
#println((x < 0) || (this-is-not-even-legitimate-code)) #ERROR
 



############################################################################
#
#			PARENTHESIS IN MULTIPLE CONDITIONS
#
############################################################################
 
x = 5
y = 0
 
println(x < 0 && y > 4 || y < 2)
 



x = 5
y = 0
 
println((x < 0) && (y > 4 || y < 2))
 



x = 5
y = 0
 
println((x < 0 && y > 4) || (y < 2))
 



####################################################
#	Multiple Conditions without Parentheses
####################################################
 
println(false || true && true)
 
println(false || true && false)
 
println(true || does-not-matter)
 



println(true && false || true)
 
println(true && false || false)
 
println(false && does-not-matter || true)
 



############################################################################
#
#			FUNCTIONS TO CHECK CONDITIONS ON VECTORS
#
############################################################################
 
####################################################
#	code 1
####################################################
 
a                = 1
b                = -1

# function indicating whether all elements satisfy the condition
are_all_positive = all([a > 0, b > 0])

# function indicating whether at least one element satisfies the condition
is_one_positive  = any([a > 0, b > 0])
 
println(are_all_positive)
 
println(is_one_positive)
 



####################################################
#	code 2
####################################################
 
x                = [1, -1]

are_all_positive = all(x .> 0)
is_one_positive  = any(x .> 0)
 
println(are_all_positive)
 
println(is_one_positive)
 



####################################################
#	Functions for Representing Multiple Conditions
####################################################
 
x                = [1, -1]

are_all_positive = all(i -> i > 0, x)
is_one_positive  = any(i -> i > 0, x)
 
println(are_all_positive)
 
println(is_one_positive)
 



x                = [1, -1]
y                = [1,  1]

are_all_positive = all.(i -> i > 0, [x,y])
is_one_positive  = any.(i -> i > 0, [x,y])
 
println(are_all_positive)
 
println(is_one_positive)
 
