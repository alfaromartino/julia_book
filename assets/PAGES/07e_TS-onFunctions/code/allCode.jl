include(joinpath(homedir(),"JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
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
 
print_asis(y)  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x   = 2

f() = 3 * x
 
print_asis(f())  #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			functions and methods
#
############################################################################
 
foo1(a,b)                  = a + b
foo1(a::String, b::String) = "This is $a and this is $b"
 
print_asis(methods(foo1)) #hide
 
print_asis(foo1(1,2)) #hide
 
print_asis(foo1("some text", "more text")) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# methods with different number of arguments
 
foo2(x)       = x
foo2(x, y)    = x + y
foo2(x, y, z) = x + y + z
 
print_asis(methods(foo2)) #hide
 
print_asis(foo2(1)) #hide
 
print_asis(foo2(1,2)) #hide
 
print_asis(foo2(1,2,3)) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = [2, 3, 4]

y = sum(x)          # 2 + 3 + 4
z = sum(log, x)     # log(2) + log(3) + log(4)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			function calls
#
############################################################################
 
foo(a, b) = 2 + a * b
 
print_asis(foo(1,2)) #hide
 
print_asis(foo(3,2)) #hide
 
print_asis(foo(3.0,2)) #hide
 
############################################################################
#
#			Remarks on Type Inference
#
############################################################################
 
x       = [1, 2, "hello"]    # Vector{Any}

foo3(x) = x[1] + x[2]        # type unstable
 
print_asis(foo3(x))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	global variables inherit their global type
####################################################
 
a         = 2
b         = 1

foo4(a)   = a * b
 
print_asis(foo4(a))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
c         = 2
d::Number = 1

foo4(c)   = c * d
 
print_asis(foo4(c))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			Type-Annotating Function Arguments Does Not Improve Performance
#
############################################################################
 
foo5(a, b) = a * b
 
print_asis(foo5(0.5, 2.0)) #hide
 
print_asis(foo5(1, 2)) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
foo6(a::Float64, b::Float64) = a * b
 
print_asis(foo6(0.5, 2.0)) #hide
 
#print_asis(foo6(1, 2)) #ERROR #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	remark
####################################################
 
revenue1(nr_tickets, price) = nr_tickets * price
 
print_asis(revenue1(3, 2)) #hide
 
print_asis(revenue1("this is ", "allowed")) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
revenue2(nr_tickets::Int64, price::Number) = nr_tickets * price
 
print_asis(revenue2(3, 2)) #hide
 
# print_asis(revenue2("this is ", "not allowed")) #ERROR #hide
 
