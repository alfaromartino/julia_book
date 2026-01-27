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
#			SECTION: "GLOBAL AND LOCAL VARIABLES"
#
############################################################################
 
x = "hello"

function foo(x)        # 'x' is local, unrelated to 'x = hello' above
    y = x + 2          # 'y' is local, 'x' refers to the function argument 
    
    return x,y
end
 
println(foo(1))
 
println(x)
 
#println(y) #error
 



z = 2

function foo(x)                 
    y = x + z          # 'x' refers to the function argument, 'z' refers to the global

    return x,y,z
end
 
println(foo(1))
 
#println(x) #error
 
println(z) #error
 
############################################################################
#
#			THE ROLE OF LOCAL VARIABLES
#
############################################################################
 
x          = 3

double()   = 2 * x
y          = double()
 



x          = 3

double(x)  = 2 * x
y          = double(x)
 



x          = 3

double(🐒) = 2 * 🐒
y          = double(x)
 



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
 
println(expenditure_iPhones)
 



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
 
println(expenditure_iPhones)
 
