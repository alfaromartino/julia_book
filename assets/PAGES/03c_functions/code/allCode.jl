include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			USER-DEFINED FUNCTIONS
#
############################################################################
 
####################################################
#	example 1
####################################################
 
function foo(x,y)
    x + y
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo(x,y) = x + y
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	example 2
####################################################
 
function foo(x,y)
    term1 = x + y
    term2 = x * y 

    return term2
end
 
print_asis(foo(10,2))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x,y)   
    term1 = x + y
    term2 = x * y           # output returned
end
 
print_asis(foo(10,2))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x,y)
    term1 = x + y
    term2 = x * y 

    return term1, term2     # a tuple, using the notation that omits the parentheses
end
 
print_asis(foo(10,2))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x,y)
    term1 = x + y
    term2 = x * y
    
    return term1 + term2
end
 
print_asis(foo(10,2))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
print_asis(foo1(2))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo2(x) = 1 + x

foo1(x) = 2 + foo2(x)
 
print_asis(foo1(2))   #hide
 
############################################################################
#
#			Functions as Operators
#
############################################################################
 
x = 1
y = 1

⊕(x,y) = log(x) + log(y)
 
print_asis(⊕(x,y))   #hide
 
print_asis(x ⊕ y)   #hide
 
############################################################################
#
#			Positional and Keyword Arguments
#
############################################################################
 
foo(x, y) = x + y
 
print_asis(foo(1,2))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo(; x, y) = x + y
 
print_asis(foo(x=1,y=1))   #hide
 
print_asis(foo(; x=1, y=1))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo(x; y) = x + y
 
print_asis(foo(1 ; y=1))   #hide
 
print_asis(foo(1 , y=1))   #hide
 
####################################################
#	Keyword Arguments with Default Values
####################################################
 
foo(x; y=1) = x + y
 
print_asis(foo(1))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo(; x=1, y=1) = x + y
 
print_asis(foo())   #hide
 
print_asis(foo(x=2))   #hide
 
####################################################
#	Passing Arguments as Inputs to Other Arguments
####################################################
 
foo(; x, y = x+1) = x + y
 
print_asis(foo(x=2))   #hide
 
####################################################
#	Splatting
####################################################
 
foo(x,y) = x + y

z = (2,3)
 
print_asis(foo(z...))   #hide
 
foo(x,y) = x + y

z = [2,3]
 
print_asis(foo(z...))   #hide
 
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

result     = map(add_two, x)
 
print_asis(result)   #hide
 
x          = [1, 2, 3]


result     = map(a -> a + 2, x)
 
print_asis(result)   #hide
 
####################################################
#	example 2
####################################################
 
x            = [1,2,3]
y            = [4,5,6]

add_two(a,b) = a + b
result       = map(add_two, x, y)
 
print_asis(result)   #hide
 
x            = [1,2,3]
y            = [4,5,6]


result       = map((a,b) -> a + b, x, y)
 
print_asis(result)   #hide
 
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

result     = map(add_two, x)
 
print_asis(result)   #hide
 
x          = [1, 2, 3]


result     = map(a -> a + 2, x)
 
print_asis(result)   #hide
 
x          = [1, 2, 3]

result     = map(x) do a
                a + 2
                end
 
print_asis(result)   #hide
 
####################################################
#	do-blocks with anonymous funcitons and multiple arguments
####################################################
 
x = [1,2,3]
y = [4,5,6]

add(a,b) = a + b
result   = map(add_two, x, y)
 
print_asis(result)   #hide
 
x        = [1,2,3]
y        = [4,5,6]


result   = map((a,b) -> a + b, x, y)
 
print_asis(result)   #hide
 
x        = [1,2,3]
y        = [4,5,6]

result   = map(x,y) do a,b      # not (a,b)
                a + b
                end
 
print_asis(result)   #hide
 
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
 
