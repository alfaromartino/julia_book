####################################################
#	PACKAGE ENVIRONMENT
####################################################
# This code allows you to reproduce the code with the exact package versions used when writing this note.
# It requires having all files (allCode_withPkgEnvironment.jl, Manifest.toml, and Project.toml) in the same folder.

import Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate() #to install the packages


############################################################################
#   AUXILIAR FOR BENCHMARKING
############################################################################
# We use `foo(ref($x))` for more accurate benchmarks of the function `foo(x)`
using BenchmarkTools
ref(x) = (Ref(x))[]


############################################################################
#
#                           START OF THE CODE 
#
############################################################################
 
# necessary packages for this file
using BenchmarkTools
 
x = 1:100

@time sum(x)         # first run -> it incorporates compilation time 
@time sum(x)         # time without compilation time -> more relevant
 
using BenchmarkTools

x = 1:100
@btime sum(ref($x))        # only average time
 
using BenchmarkTools

x = 1:100
@benchmark sum(ref($x))    # more statistics than `@btime`
 
using BenchmarkTools

@btime begin
   x = 1:100
   sum(ref($x))
end
 
using BenchmarkTools

@benchmark begin
   x = 1:100
   sum(ref($x))
end
 
############################################################################
#
#                           for-loop
#
############################################################################
 
x      = collect(1:10)
foo(x) = x .* 2

@btime foo(ref($x))
 
x      = collect(1:10)
foo()  = x .* 2

@btime foo()
 
x      = collect(1:10)
foo(x) = x .* 2

function replicate(x)
   for _ in 1:100_000
      foo(x)
   end
end

@btime replicate(ref($x))
 
x      = collect(1:10)
foo()  = x .* 2

function replicate()
   for _ in 1:100_000
      foo()
   end
end

@btime replicate()
 
