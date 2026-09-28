include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			CONDITIONALS
#
############################################################################
 
############################################################################
#
#			IF-THEN STATEMENTS
#
############################################################################
 
x = 5

if x > 0
    println("x is positive")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 5

(x > 0) && (println("x is positive"))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 5

(x ≤ 0) || (println("x is positive"))
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			IF-ELSE STATEMENTS
#
############################################################################
 
x = 5

if x > 0
    println("x is positive")
else
    println("x is not positive")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = 5

x > 0 ? println("x is positive") : println("x is not positive")
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	ifelse function
####################################################
 
x                     = [4, 2, -6]

are_elements_positive = ifelse.(x .> 0, true, false)
print_asis(are_elements_positive)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x                     = [4, 2, -6]

x_absolute_value      = ifelse.(x .≥ 0, x, -x)
print_asis(x_absolute_value)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			IF-ELSE-IF STATEMENTS
#
############################################################################
 
x = -10

if x > 0
    println("x is positive")
elseif x == 0
    println("x is zero")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x = -10

if x > 0
    println("x is positive")
elseif x == 0
    println("x is zero")
else
    println("x is negative")
end
 
