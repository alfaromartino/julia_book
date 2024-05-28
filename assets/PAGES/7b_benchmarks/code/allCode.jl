include(joinpath(homedir(),"JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using BenchmarkTools, Chairmarks
 
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
 
using BenchmarkTools

@btime begin
   x = 1:100
   sum($x)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using BenchmarkTools

@benchmark begin
   x = 1:100
   sum($x)
end
 
############################################################################
#
#      be careful when no output is returned
#      (calculations are avoided, so benchmark is meaningless)
#
############################################################################
 
using BenchmarkTools
x = 2

function foo(x, repetitions)
   for i in 1:repetitions
      x * i
   end
end

@btime foo(x, 100)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using BenchmarkTools
x = 2

function foo(x, repetitions)
   for i in 1:repetitions
      x * i
   end
end

@btime foo(x, 100_000)
 
############################################################################
#
#      PACKAGE Chairmarks (way faster, but still quite new)
#
############################################################################
 
using BenchmarkTools
using Random; Random.seed!(1234) #hide
x = rand(100)

@btime sum(x)
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using BenchmarkTools
using Random; Random.seed!(1234) #hide
x = rand(100)

@btime sum($x)
 
############################################################################
#
#      PACKAGE Chairmarks 
#      (way faster, but still quite new so we don't know if there are bugs)
#
############################################################################
 
using Chairmarks
using Random; Random.seed!(1234) #hide
x = rand(100)

display(@b sum($x))        # provides minimum time only
print_asis(@b sum($x))    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Chairmarks
using Random; Random.seed!(1234) #hide
x = rand(100)

display(@be sum($x))       # analogous to `@benchmark` in BenchmarkTools
print_asis(@be sum($x))    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Chairmarks
using Random; Random.seed!(1234) #hide

@b begin
   x = rand(100)
   sum($x)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Chairmarks
using Random; Random.seed!(1234) #hide

@be begin
   x = rand(100)
   sum($x)
end
 
############################################################################
#
#     INTERPRETING BENCHMARKS
#
############################################################################
 
using Random; Random.seed!(1234) #hide
x      = rand(100_000)

foo()  = sum(2 .* x)

@btime foo()    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(1234) #hide
x      = rand(100_000)

foo(x) = sum(a -> 2 * a, x)

@btime foo($x)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(1234) #hide
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
 
using Random; Random.seed!(1234) #hide
x      = rand(100_000)
foo(x) = sum(a -> 2 * a, x)

function replicate(x)
   for _ in 1:100_000
      foo(x)
   end
end

@btime replicate($x)    #hide
 
############################################################################
#
#      REMARK ON RANDOM NUMBERS USED ON THE WEBSITE
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
 
using Random ; Random.seed!(123) # hide
# We omit the lines that seet the seed


x = rand(100)

y = sum(x)
 
############################################################################
#
#     INTERPRETING BENCHMARKS
#
############################################################################
 
using Random; Random.seed!(1234) #hide
x      = rand(100_000)

foo()  = sum(2 .* x)

@btime foo()    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(1234) #hide
x      = rand(100_000)

foo(x) = sum(a -> 2 * a, x)

@btime foo($x)    #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
using Random; Random.seed!(1234) #hide
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
 
using Random; Random.seed!(1234) #hide
x      = rand(100_000)
foo(x) = sum(a -> 2 * a, x)

function replicate(x)
   for _ in 1:100_000
      foo(x)
   end
end

@btime replicate($x)    #hide
 
