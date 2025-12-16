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
 
############################################################################
#
#			 FUNCTIONS: TYPE INFERENCE AND MULTIPLE DISPATCH
#
############################################################################
 
############################################################################
#
#			variable scope in functions
#
############################################################################
 
x   = 2

y   = 3 * x
 
println(y)
 



x   = 2

f() = 3 * x
 
println(f())
 



############################################################################
#
#			functions and methods
#
############################################################################
 
foo1(a,b)                  = a + b
foo1(a::String, b::String) = "This is $a and this is $b"
 
println(methods(foo1))
 
println(foo1(1,2))
 
println(foo1("some text", "more text"))
 



# methods with different number of arguments
 
foo2(x)       = x
foo2(x, y)    = x + y
foo2(x, y, z) = x + y + z
 
println(methods(foo2))
 
println(foo2(1))
 
println(foo2(1,2))
 
println(foo2(1,2,3))
 



x = [2, 3, 4]

y = sum(x)          # 2 + 3 + 4
z = sum(log, x)     # log(2) + log(3) + log(4)
 



############################################################################
#
#			function calls
#
############################################################################
 
foo(a, b) = 2 + a * b
 
println(foo(1,2))
 
println(foo(3,2))
 
println(foo(3.0,2))
 
############################################################################
#
#			Remarks on Type Inference
#
############################################################################
 
x       = [1, 2, "hello"]    # Vector{Any}

foo3(x) = x[1] + x[2]        # type unstable
 
println(foo3(x))
 



####################################################
#	global variables inherit their global type
####################################################
 
a         = 2
b         = 1

foo4(a)   = a * b
 
println(foo4(a))
 



c         = 2
d::Number = 1

foo4(c)   = c * d
 
println(foo4(c))
 



############################################################################
#
#			Type-Annotating Function Arguments Does Not Improve Performance
#
############################################################################
 
foo5(a, b) = a * b
 
println(foo5(0.5, 2.0))
 
println(foo5(1, 2))
 



foo6(a::Float64, b::Float64) = a * b
 
println(foo6(0.5, 2.0))
 
#println(foo6(1, 2)) #ERROR
 



####################################################
#	remark
####################################################
 
revenue1(nr_tickets, price) = nr_tickets * price
 
println(revenue1(3, 2))
 
println(revenue1("this is ", "allowed"))
 



revenue2(nr_tickets::Int64, price::Number) = nr_tickets * price
 
println(revenue2(3, 2))
 
# println(revenue2("this is ", "not allowed")) #ERROR
 
