############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
    # uncomment if you don't have the package installed
using FastBenchmark
    

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using BenchmarkTools, Chairmarks
 
############################################################################
#
#			BENCHMARKING EXECUTION TIME
#
############################################################################
 
############################################################################
#
#      @time - built-in macro (not reliable)
#
############################################################################
 
x = 1:100

@time sum(x)         # first run                     -> it incorporates compilation time 
@time sum(x)         # time without compilation time -> relevant for each subsequent run
 



############################################################################
#
#      PACKAGE BenchmarkTools
#
############################################################################
 
using BenchmarkTools

x = 1:100
@btime sum($x)        # provides minimum time only
 



using BenchmarkTools

x = 1:100
@benchmark sum($x)    # provides more statistics than `@btime`
 



####################################################
#	interpolation with $ to treat function arguments as local variables
####################################################
 
using BenchmarkTools
Random.seed!(1234)       #setting seed for reproducibility
x = rand(100)

@btime sum(x)
 



using BenchmarkTools
Random.seed!(1234)       #setting seed for reproducibility
x = rand(100)

@btime sum($x)
 
############################################################################
#
#      PACKAGE Chairmarks 
#      (way faster, but still quite new)
#
############################################################################
 
using Chairmarks
Random.seed!(1234)       #setting seed for reproducibility
x = rand(100)

display(@b sum($x))        # provides minimum time only
println(@b sum($x))
 



using Chairmarks
Random.seed!(1234)       #setting seed for reproducibility
x = rand(100)

display(@be sum($x))       # analogous to `@benchmark` in BenchmarkTools
println(@be sum($x))
 



############################################################################
#
#      REMARK ON RANDOM NUMBERS USED ON THE WEBSITE
#
############################################################################
 
using Random

Random.seed!(1234)      # 1234 is an arbitrary number, use any number you want
x = rand(100)


y = rand(100)           # different from `x`
 



using Random

Random.seed!(1234)      # 1234 is an arbitrary number, use any number you want
x = rand(100)

Random.seed!(1234)
y = rand(100)           # identical to `x`
 



using Random
Random.seed!(123)

x = rand(100)

y = sum(x)
 



using Random ; Random.seed!(123)
# We omit the lines that seet the seed


x = rand(100)

y = sum(x)
 
############################################################################
#
#     INTERPRETING BENCHMARKS
#
############################################################################
 
Random.seed!(1234)       #setting seed for reproducibility
x      = rand(100_000)

foo()  = sum(2 .* x)

@btime foo()
 



Random.seed!(1234)       #setting seed for reproducibility
x      = rand(100_000)

foo(x) = sum(a -> 2 * a, x)

@btime foo($x)
 



Random.seed!(1234)       #setting seed for reproducibility
x      = rand(100_000)
foo()  = sum(2 .* x)

function replicate()
   for _ in 1:100_000
      foo()
   end
end

@btime replicate()
 



Random.seed!(1234)       #setting seed for reproducibility
x      = rand(100_000)
foo(x) = sum(a -> 2 * a, x)

function replicate(x)
   for _ in 1:100_000
      foo(x)
   end
end

@btime replicate($x)
 
