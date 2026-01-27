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
#			SECTION: "THE MAP FUNCTION"
#
############################################################################
 
####################################################
#	first way
####################################################
 
x          = [1, 2, 3]

output     = map(log, x)
equivalent = [log(x[1]), log(x[2]), log(x[3])]
 
println(output)
 
println(equivalent)
 



x          = [1, 2, 3]

output     = map(a -> 2 * a, x)
equivalent = [2*x[1], 2*x[2], 2*x[3]]
 
println(output)
 
println(equivalent)
 



####################################################
#	second way
####################################################
 
x          = [ 1, 2, 3]
y          = [-1,-2,-3]

output     = map(+, x, y)        # `+` exists as both operator and function
equivalent = [+(x[1],y[1]), +(x[2],y[2]), +(x[3],y[3])]
 
println(output)
 
println(equivalent)
 



x          = [ 1, 2, 3]
y          = [-1,-2,-3]

output     = map((a,b) -> a+b, x, y)
equivalent = [x[1]+y[1], x[2]+y[2], x[3]+y[3]]
 
println(output)
 
println(equivalent)
 



x          = [ 1, 2, 3]
y          = [-1,-2]

output     = map(+, x, y)        # `+` exists as both operator and function
equivalent = [+(x[1],y[1]), +(x[2],y[2])]
 
println(output)
 
println([+(x[1],y[1]), +(x[2],y[2])])
 



x          = [ 1, 2, 3]
y          = -1

output     = map(+, x, y)        # `+` exists as both operator and function
equivalent = [+(x[1],y[1])]
 
println(output)
 
println(equivalent)
 



############################################################################
#
#			BROADCASTING FUNCTIONS
#
############################################################################
 
####################################################
#	example 1
####################################################
 
# `log(a)` applies to scalars `a`
x          = [1,2,3]

output     = log.(x)
equivalent = [log(x[1]), log(x[2]), log(x[3])]
 
println(output)
 
println(equivalent)
 



square(a)  = a^2     #user-defined function for a scalar 'a'
x          = [1,2,3]

output     = square.(x)
equivalent = [square(x[1]), square(x[2]), square(x[3])]
 
println(output)
 
println(equivalent)
 
####################################################
#	example 2 
####################################################
 
# 'max(a,b)' returns 'a' if 'a>b', and 'b' otherwise
x          = [0, 4, 0]
y          = [2, 0, 8]

output     = max.(x,y)
equivalent = [max(x[1],y[1]), max(x[2],y[2]), max(x[3],y[3])]
 
println(output)
 
println(equivalent)
 



foo(a,b)   = a + b        # user-defined function for scalars 'a' and 'b'
x          = [-2, -4, -10]
y          = [ 2,  4,  10]

output     = foo.(x,y)
equivalent = [foo(x[1],y[1]), foo(x[2],y[2]), foo(x[3],y[3])]
 
println(output)
 
println(equivalent)
 
####################################################
#	example 3
####################################################
 
country = ["France", "Canada"]
is_in   = [" is in "  , " is in "]
region  = ["Europe", "North America"]

output  = string.(country, is_in, region)
 
println(output)
 
############################################################################
#
#			BROADCASTING OPERATORS
#
############################################################################
 
x      = [ 1,  2,  3]
y      = [-1, -2, -3]

output = x .+ y
 
println(output)
 



x      = [1, 2, 3]


output = .√x
 
println(output)
 
############################################################################
#
#			BROADCASTING OPERATORS with SCALARS
#
############################################################################
 
x      = [0,10,20]
y      = 5

output = x .+ y
 
println(output)
 



x      = [0,10,20]
y      = [5, 5, 5]

output = x .+ y
 
println(output)
 
####################################################
#	remark
####################################################
 
country = ["France", "Canada"]
is_in   = " is in "
region  = ["Europe", "North America"]

output  = string.(country, is_in, region)
 
println(output)
 
############################################################################
#
#			ITERABLE OBJECTS
#
############################################################################
 
####################################################
#	example 1
####################################################
 
x = (1, 2, 3)    # or simply x = 1, 2, 3
 
println(log.(x))
 
println(x .+ x)
 



x = 1:3
 
println(log.(x))
 
println(x .+ x)
 



x = (1, 2, 3)    # or simply x = 1, 2, 3
y = 1:3
 
println(x .+ y)
 



####################################################
#	example 2
####################################################
 
x         = [1, 0, 2]
y         = [1, 2, 0]

temp      = x .+ y
output    = temp .^ 2
 
println(temp)
 
println(output)
 



x         = [1, 0, 2]
y         = [1, 2, 0]

square(x) = x^2
output    = square.(x .+ y)
 
println(output)
 



x         = [1, 0, 2]
y         = [1, 2, 0]

square(x) = x^2
output    = @. square(x + y)
 
println(output)
 



############################################################################
#
#			BROADCASTING FUNCTIONS VS BROADCASTING OPERATORS
#
############################################################################
 
x                 = [1, 2, 3]

number_squared(a) = a ^ 2               # function for scalar 'a'
output            = number_squared.(x)
 
println(output)
 



x                 = [1, 2, 3]

vector_squared(x) = x .^ 2              # function for a vector 'x'
output            = vector_squared(x)   # '.' not needed (it'd be redundant)
 
println(output)
 
############################################################################
#
#			BROADCASTING OVER ONLY ONE ARGUMENT
#
############################################################################
 
####################################################
#	example 1
####################################################
 
x    = [1, 2]
list = [1, 2, 3]
 
#println(in.(x, list)) #ERROR
 



x    = [1, 2, 4]
list = [1, 2, 3]
 
println(in.(x, list))
 



####################################################
#	example 2
####################################################
 
x      = [2, 4, 6]
list   = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'

output = in.(x, [list])
 
println(output)
 



x      = [2, 4, 6]
list   = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'

output = in.(x, (list,))
 
println(output)
 



x      = [2, 4, 6]
list   = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'

output = in.(x, Ref(list))
 
println(output)
 
####################################################
#	example 3
####################################################
 
x      = [2, 4, 6]
list   = [1, 2, 3]

output = x .∈ (list,)       # only 'x[1]' equals an element in 'list'
 
println(output)
 



x      = [2, 4, 6]
list   = [1, 2, 3]

output = x .∈ Ref(list)     # only 'x[1]' equals an element in 'list'
 
println(output)
 
############################################################################
#
#			CURRYING (optional)
#
############################################################################
 
####################################################
#	example 1
####################################################
 
addition(x,y)  = 2 * x + y
 
println(addition(2,1))
 



addition(x,y)  = 2 * x + y

# the following are equivalent
curried1(x)    = (y -> addition(x,y))
curried2       = x -> (y -> addition(x,y))
 
println(curried1(2)(1))
 
println(curried2(2)(1))
 



addition(x,y)  = 2 * x + y
curried(x)     = (y -> addition(x,y))

# the following are equivalent
f              = curried(2)          # function of 'y', with 'x' fixed to 2
g(y)           = addition(2,y)
 
println(f(1))
 
println(g(1))
 
####################################################
#	example 2
####################################################
 
a             = 2
b             = [1,2,3]

addition(x,y) = 2 * x + y
curried(x)    = (y -> addition(x,y))   # 'curried(x)' is a function, and 'y' its argument
 
println(curried(a).(b))
 



a             = 2
b             = [1,2,3]

addition(x,y) = 2 * x + y
curried(x)    = (y -> addition(x,y))

#the following are equivalent
f             = curried(a)             # 'foo1' is a function, and 'y' its argument
g(y)          = addition(2,y)
 
println(f.(b))
 
println(g.(b))
 
####################################################
#	example 3
####################################################
 
x    = [2, 4, 6]
list = [1, 2, 3]
 
println(in.(x,Ref(list)))
 



x    = [2, 4, 6]
list = [1, 2, 3]

our_in(list_elements) = (x -> in(x,list_elements))   # 'our_in(list_elements)' is a function
 
println(our_in(list).(x))
 



x    = [2, 4, 6]
list = [1, 2, 3]
 
println(in(list).(x))
 
