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
#			SECTION: "USER-DEFINED FUNCTIONS"
#
############################################################################
 
####################################################
#	example 1
####################################################
 
function foo(x,y)
    x + y
end
 



foo(x,y) = x + y
 



####################################################
#	example 2
####################################################
 
function foo(x,y)
    term1 = x + y
    term2 = x * y 

    return term2
end
 
println(foo(1,2))
 



function foo(x,y)   
    term1 = x + y
    term2 = x * y         # output returned
end
 
println(foo(1,2))
 



function foo(x,y)
    term1 = x + y
    term2 = x * y 

    return term1, term2   # a tuple (notation that omits the parentheses)
end
 
println(foo(1,2))
 



function foo(x,y)
    term1 = x + y
    term2 = x * y
    
    return term1 + term2
end
 
println(foo(1,2))
 



####################################################
#	Functions without Arguments
####################################################
 
function foo()
    a = 1
    b = 1
    return a + b
end
 
####################################################
#	The Order In Which Functions Are Defined is Irrelevant
####################################################
 
foo1(x) = 2 + foo2(x)

foo2(x) = 1 + x
 
println(foo1(2))
 



foo2(x) = 1 + x

foo1(x) = 2 + foo2(x)
 
println(foo1(2))
 
############################################################################
#
#			Functions as Operators
#
############################################################################
 
x = 1
y = 1

⊕(x,y) = log(x) + log(y)
 
println(⊕(x,y))
 
println(x ⊕ y)
 
############################################################################
#
#			Positional and Keyword Arguments
#
############################################################################
 
foo(x, y) = x + y
 
println(foo(1,2))
 



foo(; x, y) = x + y
 
println(foo(x=1,y=1))
 
println(foo(; x=1, y=1))
 



foo(x; y) = x + y
 
println(foo(1 ; y=1))
 
println(foo(1 , y=1))
 
####################################################
#	Keyword Arguments with Default Values
####################################################
 
foo(x; y=1) = x + y
 
println(foo(1))
 



foo(; x=1, y=1) = x + y
 
println(foo())
 
println(foo(x=2))
 
####################################################
#	Passing Arguments as Inputs to Other Arguments
####################################################
 
foo(; x, y = x+1) = x + y
 
println(foo(x=2))
 
####################################################
#	Splatting
####################################################
 
foo(x,y) = x + y

z = (2,3)
 
println(foo(z...))
 
foo(x,y) = x + y

z = [2,3]
 
println(foo(z...))
 
############################################################################
#
#			ANONYMOUS FUNCTIONS
#
############################################################################
 
####################################################
#	example 1
####################################################
 
x          = [1, 2, 3]
add_two(a) = a + 2

output     = map(add_two, x)
 
println(output)
 
x          = [1, 2, 3]


output     = map(a -> a + 2, x)
 
println(output)
 
####################################################
#	example 2
####################################################
 
x               = [1,2,3]
y               = [4,5,6]
add_values(a,b) = a + b

output          = map(add_values, x, y)
 
println(output)
 
x               = [1,2,3]
y               = [4,5,6]


output          = map((a,b) -> a + b, x, y)
 
println(output)
 
####################################################
#	The "Do-Block" Syntax
####################################################
 
####################################################
#	notation
####################################################
 
#=
foo(<vector>) do <arguments of inner function>
    # body of inner function
    end
=#
 
####################################################
#	example
####################################################
 
x          = [1, 2, 3]
add_two(a) = a + 2

output     = map(add_two, x)
 
println(output)
 
x          = [1, 2, 3]


output     = map(a -> a + 2, x)
 
println(output)
 
x          = [1, 2, 3]

output     = map(x) do a
                a + 2
                end
 
println(output)
 
####################################################
#	do-blocks with anonymous funcitons and multiple arguments
####################################################
 
x               = [1,2,3]
y               = [4,5,6]
add_values(a,b) = a + b

output          = map(add_values, x, y)
 
println(output)
 
x               = [1,2,3]
y               = [4,5,6]


output          = map((a,b) -> a + b, x, y)
 
println(output)
 
x               = [1,2,3]
y               = [4,5,6]

output          = map(x,y) do a,b   # not (a,b)
                             a + b
                           end
 
println(output)
 
############################################################################
#
#			FUNCTION DOCUMENTATION
#
############################################################################
 
"This function is written in a standard way. It takes a number and adds two to it."
function add_two(a)
   a + 2
end
 
"This function is written in a compact form. It takes a number and adds three to it."
add_three(a) = a + 3
 
