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
 
# necessary packages for this file
using Random, Base.Threads
 
############################################################################
#
#			SECTION: "PARALLEL FOR-LOOPS"
#
############################################################################
 
############################################################################
#
#			SOME PRELIMINARIES
#
############################################################################
 
@sync begin
    for i in 1:4
        @spawn println("Iteration $i is computed on Thread $(threadid())")
    end
end
 



@sync begin
    @spawn println("Iteration 1 is computed on Thread $(threadid())")
    @spawn println("Iteration 2 is computed on Thread $(threadid())")
    @spawn println("Iteration 3 is computed on Thread $(threadid())")
    @spawn println("Iteration 4 is computed on Thread $(threadid())")
end
 



####################################################
#	differences between approaches
####################################################
 
for i in 1:4
    println("Iteration $i is computed on Thread $(threadid())")
end
 



@threads for i in 1:4
    println("Iteration $i is computed on Thread $(threadid())")
end
 



@sync begin
    for i in 1:4
        @spawn println("Iteration $i is computed on Thread $(threadid())")
    end
end
 



# typical application of `@threads`
 
Random.seed!(1234)       #setting seed for reproducibility
function foo(x)
    output = similar(x)

    @threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return output
end
 



############################################################################
#
#			@spawn vs @threads
#
############################################################################
 
function job(i; time_working)
    println("Iteration $i is on Thread $(threadid())")

    start_time = time()

    while time() - start_time < time_working
        1 + 1                  # compute `1+1` repeatedly during `time_working` seconds
    end    
end
 
####################################################
#	scenario 1: unbalanced workload
####################################################
 
function foo(nr_iterations)
    for i in 1:nr_iterations
      job(i; time_working = i)      
    end
end
foo(1);
 
@ctime foo(4)
 



function foo(nr_iterations)
    @threads for i in 1:nr_iterations
        job(i; time_working = i)        
    end
end
foo(1);
 
@ctime foo(4)
 



function foo(nr_iterations)
    @sync begin
        for i in 1:nr_iterations
            @spawn job(i; time_working = i)            
        end
    end
end
foo(1);
 
@ctime foo(4)
 



####################################################
#	scenario 2: balanced workload
####################################################
 
function foo(nr_iterations)
    fixed_time = 1 / 1_000_000

    for i in 1:nr_iterations
        job(i; time_working = fixed_time)
    end
end
foo(1);
GC.gc() ;
 
@ctime foo(1_000_000)
 



function foo(nr_iterations)
    fixed_time = 1 / 1_000_000

    @threads for i in 1:nr_iterations
        job(i; time_working = fixed_time)
    end
end
foo(1);
GC.gc() ;
 
@ctime foo(1_000_000)
 



function foo(nr_iterations)
    fixed_time = 1 / 1_000_000

    @sync begin
        for i in 1:nr_iterations
            @spawn job(i; time_working = fixed_time)
        end
    end
end
foo(1);
GC.gc() ;
 
@ctime foo(1_000_000)
 
