include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			GLOBAL AND LOCAL VARIABLES
#
############################################################################
 
x = "hello"

function foo(x)        # 'x' is local, unrelated to 'x = hello' above
    y = x + 2          # 'y' is local, 'x' refers to the function argument 
    
    return x,y
end
 
print_asis(foo(1))   #hide
 
print_asis(x)   #hide
 
#print_asis(y) #error   #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
z = 2

function foo(x)                 
    y = x + z          # 'x' refers to the function argument, 'z' refers to the global

    return x,y,z
end
 
print_asis(foo(1))   #hide
 
#print_asis(x) #error  #hide
 
print_asis(z) #error   #hide
 
############################################################################
#
#			THE ROLE OF LOCAL VARIABLES
#
############################################################################
 
x          = 3

double()   = 2 * x
y          = double()
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = 3

double(x)  = 2 * x
y          = double(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x          = 3

double(🐒) = 2 * 🐒
y          = double(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			RECOMMENDATIONS FOR THE USE OF FUNCTIONS
#
############################################################################
 
####################################################
#	Avoid Redefining Variables within Functions
####################################################
 
function foo(x)
   x      = 2 + x           # redefines the argument
   
   y      = 2 * x
   y      = x + y           # redefines a local variable
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo(x)
   z      = 2 + x           # new variable
   
   y      = 2 * x
   output = z + y           # new variable
end
 
####################################################
#	Another Issue of Redefining Variables
####################################################
 
x = 2

function foo()
    y = x + 2
    x = x + 4

    return x
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			EXAMPLE OF MODULARITY (optional)
#
############################################################################
 
####################################################
#	description
####################################################
 
expenditure(price, quantity, tax_rate) = price * quantity * (1 + tax_rate)
 
value_before_taxes(price, quantity)       = price * quantity
valueAdded_tax(price, quantity, tax_rate) = price * quantity * tax_rate     #it'll define the variable 'tax_paid'

expenditure(price, quantity, tax_paid) = value_before_taxes(price, quantity) + tax_paid
 
####################################################
#	alternative
####################################################
 
#functions to compute expenditure
expenditure(price, quantity, tax_rate) = price * quantity * (1 + tax_rate)




#information 
price    = 1000
quantity = 2
tax_rate = 5 / 100

#computation
expenditure_iPhones = expenditure(price, quantity, tax_rate)
 
print_asis(expenditure_iPhones) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
#functions to compute expenditure
value_before_taxes(price, quantity)       = price * quantity
valueAdded_tax(price, quantity, tax_rate) = price * quantity * tax_rate

expenditure(gross_value, tax_paid) = gross_value + tax_paid

#information 
price    = 1000
quantity = 2
tax_rate = 5 / 100

#computation
gross_value         = value_before_taxes(price, quantity)
tax_paid            = valueAdded_tax(price, quantity, tax_rate)

expenditure_iPhones = expenditure(gross_value, tax_paid)
 
print_asis(expenditure_iPhones) #hide
 
