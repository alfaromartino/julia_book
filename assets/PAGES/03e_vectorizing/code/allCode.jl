include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			THE MAP FUNCTION
#
############################################################################
 
####################################################
#	first way
####################################################
 
x          = [1, 2, 3]

output     = map(log, x)
equivalent = [log(x[1]), log(x[2]), log(x[3])]
 
print_compact(output)   #hide
 
print_compact(equivalent)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [1, 2, 3]

output     = map(a -> 2 * a, x)
equivalent = [2*x[1], 2*x[2], 2*x[3]]
 
print_asis(output)   #hide
 
print_asis(equivalent)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	second way
####################################################
 
x          = [ 1, 2, 3]
y          = [-1,-2,-3]

output     = map(+, x, y)        # `+` exists as both operator and function
equivalent = [+(x[1],y[1]), +(x[2],y[2]), +(x[3],y[3])]
 
print_asis(output)   #hide
 
print_asis(equivalent)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [ 1, 2, 3]
y          = [-1,-2,-3]

output     = map((a,b) -> a+b, x, y)
equivalent = [x[1]+y[1], x[2]+y[2], x[3]+y[3]]
 
print_asis(output)   #hide
 
print_asis(equivalent)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [ 1, 2, 3]
y          = [-1,-2]

output     = map(+, x, y)        # `+` exists as both operator and function
equivalent = [+(x[1],y[1]), +(x[2],y[2])]
 
print_asis(output)   #hide
 
print_asis([+(x[1],y[1]), +(x[2],y[2])])    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = [ 1, 2, 3]
y          = -1

output     = map(+, x, y)        # `+` exists as both operator and function
equivalent = [+(x[1],y[1])]
 
print_asis(output)   #hide
 
print_asis(equivalent)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
print_compact(output)   #hide
 
print_compact(equivalent)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
square(a)  = a^2     #user-defined function for a scalar 'a'
x          = [1,2,3]

output     = square.(x)
equivalent = [square(x[1]), square(x[2]), square(x[3])]
 
print_asis(output)   #hide
 
print_asis(equivalent)   #hide
 
####################################################
#	example 2 
####################################################
 
# 'max(a,b)' returns 'a' if 'a>b', and 'b' otherwise
x          = [0, 4, 0]
y          = [2, 0, 8]

output     = max.(x,y)
equivalent = [max(x[1],y[1]), max(x[2],y[2]), max(x[3],y[3])]
 
print_asis(output)   #hide
 
print_asis(equivalent)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo(a,b)   = a + b        # user-defined function for scalars 'a' and 'b'
x          = [-2, -4, -10]
y          = [ 2,  4,  10]

output     = foo.(x,y)
equivalent = [foo(x[1],y[1]), foo(x[2],y[2]), foo(x[3],y[3])]
 
print_asis(output)   #hide
 
print_asis(equivalent)   #hide
 
####################################################
#	example 3
####################################################
 
country = ["France", "Canada"]
is_in   = [" is in "  , " is in "]
region  = ["Europe", "North America"]

output  = string.(country, is_in, region)
 
print_asis(output)     #hide
 
############################################################################
#
#			BROADCASTING OPERATORS
#
############################################################################
 
x      = [ 1,  2,  3]
y      = [-1, -2, -3]

output = x .+ y
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1, 2, 3]


output = .√x
 
print_compact(output)   #hide
 
############################################################################
#
#			BROADCASTING OPERATORS with SCALARS
#
############################################################################
 
x      = [0,10,20]
y      = 5

output = x .+ y
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [0,10,20]
y      = [5, 5, 5]

output = x .+ y
 
print_asis(output)   #hide
 
####################################################
#	remark
####################################################
 
country = ["France", "Canada"]
is_in   = " is in "
region  = ["Europe", "North America"]

output  = string.(country, is_in, region)
 
print_asis(output)     #hide
 
############################################################################
#
#			ITERABLE OBJECTS
#
############################################################################
 
####################################################
#	example 1
####################################################
 
x = (1, 2, 3)    # or simply x = 1, 2, 3
 
print_compact(log.(x))   #hide
 
print_asis(x .+ x)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 1:3
 
print_asis(log.(x))   #hide
 
print_asis(x .+ x)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = (1, 2, 3)    # or simply x = 1, 2, 3
y = 1:3
 
print_asis(x .+ y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	example 2
####################################################
 
x         = [1, 0, 2]
y         = [1, 2, 0]

temp      = x .+ y
output    = temp .^ 2
 
print_asis(temp)   #hide
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 0, 2]
y         = [1, 2, 0]

square(x) = x^2
output    = square.(x .+ y)
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 0, 2]
y         = [1, 2, 0]

square(x) = x^2
output    = @. square(x + y)
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			BROADCASTING FUNCTIONS VS BROADCASTING OPERATORS
#
############################################################################
 
x                 = [1, 2, 3]

number_squared(a) = a ^ 2               # function for scalar 'a'
output            = number_squared.(x)
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                 = [1, 2, 3]

vector_squared(x) = x .^ 2              # function for a vector 'x'
output            = vector_squared(x)   # '.' not needed (it'd be redundant)
 
print_asis(output)   #hide
 
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
 
#print_asis(in.(x, list)) #ERROR   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [1, 2, 4]
list = [1, 2, 3]
 
print_asis(in.(x, list))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	example 2
####################################################
 
x      = [2, 4, 6]
list   = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'

output = in.(x, [list])
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [2, 4, 6]
list   = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'

output = in.(x, (list,))
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [2, 4, 6]
list   = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'

output = in.(x, Ref(list))
 
print_asis(output)   #hide
 
####################################################
#	example 3
####################################################
 
x      = [2, 4, 6]
list   = [1, 2, 3]

output = x .∈ (list,)       # only 'x[1]' equals an element in 'list'
 
print_asis(output)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [2, 4, 6]
list   = [1, 2, 3]

output = x .∈ Ref(list)     # only 'x[1]' equals an element in 'list'
 
print_asis(output)   #hide
 
############################################################################
#
#			CURRYING (optional)
#
############################################################################
 
####################################################
#	example 1
####################################################
 
addition(x,y)  = 2 * x + y
 
print_asis(addition(2,1))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
addition(x,y)  = 2 * x + y

# the following are equivalent
curried1(x)    = (y -> addition(x,y))
curried2       = x -> (y -> addition(x,y))
 
print_asis(curried1(2)(1))   #hide
 
print_asis(curried2(2)(1))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
addition(x,y)  = 2 * x + y
curried(x)     = (y -> addition(x,y))

# the following are equivalent
f              = curried(2)          # function of 'y', with 'x' fixed to 2
g(y)           = addition(2,y)
 
print_asis(f(1))   #hide
 
print_asis(g(1))   #hide
 
####################################################
#	example 2
####################################################
 
a             = 2
b             = [1,2,3]

addition(x,y) = 2 * x + y
curried(x)    = (y -> addition(x,y))   # 'curried(x)' is a function, and 'y' its argument
 
print_asis(curried(a).(b))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
a             = 2
b             = [1,2,3]

addition(x,y) = 2 * x + y
curried(x)    = (y -> addition(x,y))

#the following are equivalent
f             = curried(a)             # 'foo1' is a function, and 'y' its argument
g(y)          = addition(2,y)
 
print_asis(f.(b))   #hide
 
print_asis(g.(b))   #hide
 
####################################################
#	example 3
####################################################
 
x    = [2, 4, 6]
list = [1, 2, 3]
 
print_asis(in.(x,Ref(list)))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [2, 4, 6]
list = [1, 2, 3]

our_in(list_elements) = (x -> in(x,list_elements))   # 'our_in(list_elements)' is a function
 
print_asis(our_in(list).(x))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [2, 4, 6]
list = [1, 2, 3]
 
print_asis(in(list).(x))   #hide
 
