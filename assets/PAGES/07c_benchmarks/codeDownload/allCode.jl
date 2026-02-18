include(joinpath(homedir(),"JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using BenchmarkTools, Chairmarks
 
############################################################################
#
#			        SECTION: "BENCHMARKING EXECUTION TIME"
#
############################################################################
 
############################################################################
#
#	@time - built-in macro (not reliable)
#
############################################################################
 
x = 1:100

@time sum(x)         # first run                     -> it incorporates compilation time 
@time sum(x)         # time without compilation time -> relevant for each subsequent run
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#	PACKAGE BenchmarkTools
#
############################################################################
 
using BenchmarkTools

x = 1:100
@btime sum($x)        # provides minimum time only
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using BenchmarkTools

x = 1:100
@benchmark sum($x)    # provides more statistics than `@btime`
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	interpolation with $ to treat function arguments as local variables
####################################################
 
using BenchmarkTools
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(100)

@btime sum(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using BenchmarkTools
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(100)

@btime sum($x)
 
############################################################################
#
#	PACKAGE Chairmarks (way faster, but still quite new)
#
############################################################################
 
using Chairmarks
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(100)

display(@b sum($x))        # provides minimum time only
print_asis(@b sum($x))    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Chairmarks
Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(100)

display(@be sum($x))       # analogous to `@benchmark` in BenchmarkTools
print_asis(@be sum($x))    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#	REMARK ON RANDOM NUMBERS FOR BENCHMARKING
#
############################################################################
 
using Random

Random.seed!(1234)      # 1234 is an arbitrary number, use any number you want
x = rand(100)


y = rand(100)           # different from `x`
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random

Random.seed!(1234)      # 1234 is an arbitrary number, use any number you want
x = rand(100)

Random.seed!(1234)
y = rand(100)           # identical to `x`
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random
Random.seed!(123)

x = rand(100)

y = sum(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random ; Random.seed!(123) #hide
# We omit the lines that seet the seed


x = rand(100)

y = sum(x)
 
############################################################################
#
#	BENCHMARKS IN PERSPECTIVE
#
############################################################################
 
# example 1
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(100_000)

foo()  = sum(2 .* x)

@btime foo()    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(100_000)

foo(x) = sum(a -> 2 * a, x)

@btime foo($x)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# example 2
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(100_000)
foo()  = sum(2 .* x)

function replicate()
   for _ in 1:100_000
      foo()
   end
end

@btime replicate()    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
Random.seed!(1234)       #setting seed for reproducibility #hide
x      = rand(100_000)
foo(x) = sum(a -> 2 * a, x)

function replicate(x)
   for _ in 1:100_000
      foo(x)
   end
end

@btime replicate($x)    #hide
 
