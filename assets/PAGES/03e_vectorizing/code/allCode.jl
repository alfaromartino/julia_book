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
 
x = [1, 2, 3]


z = map(log,x)
 
print_asis(z)   #hide
 
print_asis([log(x[1]), log(x[2]), log(x[3])])   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [1, 2, 3]


z = map(a -> 2 * a, x)
 
print_asis(z)   #hide
 
print_asis([2*x[1], 2*x[2], 2*x[3]])    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	second way
####################################################
 
x = [ 1, 2, 3]
y = [-1,-2,-3]

z = map(+, x, y)        # recall that `+` exists as both operator and function
 
print_asis(z)   #hide
 
print_asis([+(x[1],y[1]), +(x[2],y[2]), +(x[3],y[3])])    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [ 1, 2, 3]
y = [-1,-2,-3]

z = map((a,b) -> a+b, x, y)
 
print_asis(z)   #hide
 
print_asis([x[1]+y[1], x[2]+y[2], x[3]+y[3]])    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [ 1, 2, 3]
y = [-1,-2]

z = map(+, x, y)        # `+` is both an operator and a function
 
print_asis(z)   #hide
 
print_asis([+(x[1],y[1]), +(x[2],y[2])])    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [ 1, 2, 3]
y =  -1

z = map(+, x, y)        # `+` is both an operator and a function
 
print_asis(z)   #hide
 
print_asis([+(x[1],y[1])])    #hide
 
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
 
# `log(a)` is a function appying to scalars `a`

x         = [1,2,3]
 
print_asis(log.(x))   #hide
 
print_asis([log(x[1]), log(x[2]), log(x[3])])   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
square(a) = a^2     #user-defined function for a single element 'a'

x         = [1,2,3]
 
print_asis(square.(x))   #hide
 
print_asis([square(x[1]), square(x[2]), square(x[3])])   #hide
 
####################################################
#	example 2 
####################################################
 
# 'max(a,b)' returns 'a' if 'a>b', and 'b' otherwise

x        = [0, 4, 0]
y        = [2, 0, 8]
 
print_asis(max.(x,y))   #hide
 
print_asis([max(x[1],y[1]), max(x[2],y[2]), max(x[3],y[3])])   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo(a,b) = a + b        # user-defined function for scalars 'a' and 'b'

x        = [-2, -4, -10]
y        = [ 2,  4,  10]
 
print_asis(foo.(x,y))   #hide
 
print_asis([foo(x[1],y[1]), foo(x[2],y[2]), foo(x[3],y[3])])   #hide
 
####################################################
#	example 3
####################################################
 
country = ["France", "Canada"]
is_in   = [" is in "  , " is in "]
region  = ["Europe", "North America"]
 
print_asis(string.(country, is_in, region))     #hide
 
############################################################################
#
#			BROADCASTING OPERATORS
#
############################################################################
 
x = [ 1,  2,  3]
y = [-1, -2, -3]
 
print_asis(x .+ y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [1, 2, 3]
 
print_compact(.√x)   #hide
 
############################################################################
#
#			BROADCASTING OPERATORS with SCALARS
#
############################################################################
 
x = [0,10,20]
y = 5
 
print_asis(x .+ y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [0,10,20]
y = [5, 5, 5]
 
print_asis(x .+ y)   #hide
 
####################################################
#	remark
####################################################
 
country = ["France", "Canada"]
is_in   = " is in "
region  = ["Europe", "North America"]
 
print_asis(string.(country, is_in, region))     #hide
 
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
z         = temp .^ 2
 
print_asis(temp)   #hide
 
print_asis(z)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 0, 2]
y         = [1, 2, 0]

square(x) = x^2
 
print_asis(square.(x .+ y))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 0, 2]
y         = [1, 2, 0]

square(x) = x^2
 
print_asis(@. square(x + y))   #hide
 
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

number_squared(a) = a ^ 2         # function for scalar 'a'
 
print_asis(number_squared.(x))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                 = [1, 2, 3]

vector_squared(x) = x .^ 2         # function for a vector 'x'
 
print_asis(vector_squared(x))   #hide
 
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
 
x    = [2, 4, 6]
list = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'
 
print_asis(in.(x, [list]))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [2, 4, 6]
list = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'
 
print_asis(in.(x, (list,)))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [2, 4, 6]
list = [1, 2, 3]        # 'x[1]' equals the element 2 in 'list'
 
print_asis(in.(x, Ref(list)))   #hide
 
####################################################
#	example 3
####################################################
 
x    = [2, 4, 6]
list = [1, 2, 3]
 
print_asis(x .∈ (list,))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [2, 4, 6]
list = [1, 2, 3]
 
print_asis(x .∈ Ref(list))   #hide
 
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
 
