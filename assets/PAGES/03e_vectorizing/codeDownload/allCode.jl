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
#			THE MAP FUNCTION
#
############################################################################
 
####################################################
#	first way
####################################################
 
x = [1, 2, 3]


z = map(log,x)
 
println(z)
 
println([log(x[1]), log(x[2]), log(x[3])])
 



x = [1, 2, 3]


z = map(a -> 2 * a, x)
 
println(z)
 
println([2*x[1], 2*x[2], 2*x[3]])
 



####################################################
#	second way
####################################################
 
x = [ 1, 2, 3]
y = [-1,-2,-3]

z = map(+, x, y)        # recall that `+` exists as both operator and function
 
println(z)
 
println([+(x[1],y[1]), +(x[2],y[2]), +(x[3],y[3])])
 



x = [ 1, 2, 3]
y = [-1,-2,-3]

z = map((a,b) -> a+b, x, y)
 
println(z)
 
println([x[1]+y[1], x[2]+y[2], x[3]+y[3]])
 



x = [ 1, 2, 3]
y = [-1,-2]

z = map(+, x, y)        # `+` is both an operator and a function
 
println(z)
 
println([+(x[1],y[1]), +(x[2],y[2])])
 



x = [ 1, 2, 3]
y =  -1

z = map(+, x, y)        # `+` is both an operator and a function
 
println(z)
 
println([+(x[1],y[1])])
 



############################################################################
#
#			BROADCASTING FUNCTIONS
#
############################################################################
 
####################################################
#	example 1
####################################################
 
# `log(a)` is a function appying to scalars `a`

x         = [1,2,3]
 
println(log.(x))
 
println([log(x[1]), log(x[2]), log(x[3])])
 



square(a) = a^2     #user-defined function for a single element 'a'

x         = [1,2,3]
 
println(square.(x))
 
println([square(x[1]), square(x[2]), square(x[3])])
 
####################################################
#	example 2 
####################################################
 
# 'max(a,b)' returns 'a' if 'a>b', and 'b' otherwise

x        = [0, 4, 0]
y        = [2, 0, 8]
 
println(max.(x,y))
 
println([max(x[1],y[1]), max(x[2],y[2]), max(x[3],y[3])])
 



foo(a,b) = a + b        # user-defined function for scalars 'a' and 'b'

x        = [-2, -4, -10]
y        = [ 2,  4,  10]
 
println(foo.(x,y))
 
println([foo(x[1],y[1]), foo(x[2],y[2]), foo(x[3],y[3])])
 
####################################################
#	example 3
####################################################
 
country = ["France", "Canada"]
is_in   = [" is in "  , " is in "]
region  = ["Europe", "North America"]
 
println(string.(country, is_in, region))
 
############################################################################
#
#			BROADCASTING OPERATORS
#
############################################################################
 
x = [ 1,  2,  3]
y = [-1, -2, -3]
 
println(x .+ y)
 



x = [1, 2, 3]
 
println(.√x)
 
############################################################################
#
#			BROADCASTING OPERATORS with SCALARS
#
############################################################################
 
x = [0,10,20]
y = 5
 
println(x .+ y)
 



x = [0,10,20]
y = [5, 5, 5]
 
println(x .+ y)
 
####################################################
#	remark
####################################################
 
country = ["France", "Canada"]
is_in   = " is in "
region  = ["Europe", "North America"]
 
println(string.(country, is_in, region))
 
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
z         = temp .^ 2
 
println(temp)
 
println(z)
 



x         = [1, 0, 2]
y         = [1, 2, 0]

square(x) = x^2
 
println(square.(x .+ y))
 



x         = [1, 0, 2]
y         = [1, 2, 0]

square(x) = x^2
 
println(@. square(x + y))
 



############################################################################
#
#			BROADCASTING FUNCTIONS VS BROADCASTING OPERATORS
#
############################################################################
 
x                 = [1, 2, 3]

number_squared(a) = a ^ 2         # function for scalar 'a'
 
println(number_squared.(x))
 



x                 = [1, 2, 3]

vector_squared(x) = x .^ 2         # function for a vector 'x'
 
println(vector_squared(x))
 
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
 
x    = [2, 4, 6]
list = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'
 
println(in.(x, [list]))
 



x    = [2, 4, 6]
list = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'
 
println(in.(x, (list,)))
 



x    = [2, 4, 6]
list = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'
 
println(in.(x, Ref(list)))
 
####################################################
#	example 3
####################################################
 
x    = [2, 4, 6]
list = [1, 2, 3]
 
println(x .∈ (list,))
 



x    = [2, 4, 6]
list = [1, 2, 3]
 
println(x .∈ Ref(list))
 
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
 
