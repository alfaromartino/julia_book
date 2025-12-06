include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			CONDITIONS
#
############################################################################
 
####################################################
#	example
####################################################
 
x = 2

#`y` equals `true` or `false`
y = (x > 0)
 
print_asis(y)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 2

#'z' element equals 'true' or 'false', represented by 1 or 0
z = [x > 0, x < 0]
 
print_asis(z)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
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
 
print_asis(z1)   #hide
 
print_asis(z2)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 2

# is `x` positive?
y1 = (x > 0)

# is `x` not lower than zero nor equal to zero? (equivalent)
y2 = !(x ≤ 0)
 
print_asis(y1)   #hide
 
print_asis(y2)   #hide
 
####################################################
#	Logical Operators as Short-Circuit Operators
####################################################
 
x = 10
 
print_asis((x < 0) && (this-is-not-even-legitimate-code))   #hide
 
#print_asis((x > 0) && (this-is-not-even-legitimate-code)) #ERROR   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 10
 
print_asis((x > 0) || (this-is-not-even-legitimate-code))   #hide
 
#print_asis((x < 0) || (this-is-not-even-legitimate-code)) #ERROR   #hide
 
############################################################################
#
#			PARENTHESIS IN MULTIPLE CONDITIONS
#
############################################################################
 
x = 5
y = 0
 
print_asis(x < 0 && y > 4 || y < 2)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 5
y = 0
 
print_asis((x < 0) && (y > 4 || y < 2))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 5
y = 0
 
print_asis((x < 0 && y > 4) || (y < 2))   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	Multiple Conditions without Parentheses
####################################################
 
print_asis(false || true && true)   #hide
 
print_asis(false || true && false)   #hide
 
print_asis(true || does-not-matter)   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
print_asis(true && false || true)   #hide
 
print_asis(true && false || false)   #hide
 
print_asis(false && does-not-matter || true)   #hide
 
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
 
print_asis(are_all_positive)    #hide
 
print_asis(is_one_positive)    #hide
 
####################################################
#	code 2
####################################################
 
x                = [1, -1]

are_all_positive = all(x .> 0)
is_one_positive  = any(x .> 0)
 
print_asis(are_all_positive)    #hide
 
print_asis(is_one_positive)    #hide
 
####################################################
#	Functions for Representing Multiple Conditions
####################################################
 
x                = [1, -1]

are_all_positive = all(i -> i > 0, x)
is_one_positive  = any(i -> i > 0, x)
 
print_asis(are_all_positive)    #hide
 
print_asis(is_one_positive)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                = [1, -1]
y                = [1,  1]

are_all_positive = all.(i -> i > 0, [x,y])
is_one_positive  = any.(i -> i > 0, [x,y])
 
print_asis(are_all_positive)    #hide
 
print_asis(is_one_positive)    #hide
 
