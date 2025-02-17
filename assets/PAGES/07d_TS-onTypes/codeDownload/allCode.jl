############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# For more accurate results, we benchmark code through functions and interpolate each argument.
    # this means that benchmarking a function `foo(x)` makes use of `foo($x)`
using BenchmarkTools

# The following defines the macro `@fast_btime foo($x)`
    # `@fast_btime` is equivalent to `@btime` but substantially faster
    # if you want to use it, you should replace `@btime` with `@fast_btime`
    # by default, if `@fast_btime` doesn't provide allocations, it means there are none
using Chairmarks
macro fast_btime(ex)
    return quote
        display(@b $ex)
    end
end

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Chairmarks, BenchmarkTools
 
############################################################################
#
#           TYPE STABILITY WITH VECTORS
#
############################################################################
 

 

 

 

 

 

 
############################################################################
#
#           TYPE STABILITY WITH TUPLES
#
############################################################################
 
############################################################################
#  TUPLES ALLOWS HETEROGENEOUS TYPES OF ELEMENTS
############################################################################
 

 

 

 
############################################################################
#  VECTORS CONTAIN LESS INFORMATION THAN TUPLES
############################################################################
 

 

 

 

 

 
############################################################################
#  INFERENCE IS BY TYPE, NOT VALUE
############################################################################
 

 



