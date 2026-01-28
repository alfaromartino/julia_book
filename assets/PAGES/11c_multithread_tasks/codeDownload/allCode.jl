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
#			SECTION: "TASK-BASED PARALLELISM: @SPAWN"
#
############################################################################
 
############################################################################
#
#			ENABLING MULTITHREADING
#
############################################################################
 
# package `Threads` is automatically imported when you start a Julia session 

Threads.nthreads()
println(Threads.nthreads())
 



using Base.Threads      # or `using .Threads`

nthreads()
println(nthreads())
 



############################################################################
#
#			TASK-BASED PARALLELISM: @SPAWN
#
############################################################################
 
####################################################
#	`fetch`
####################################################
 
x = rand(10); y = rand(10)

function foo(x)
    a      = x .* -2
    b      = x .*  2
    
    a,b
end
 



x = rand(10); y = rand(10)

function foo(x)
    task_a = @spawn x .* -2
    task_b = @spawn x .*  2
    
    a,b    = fetch.((task_a, task_b))
end
 



####################################################
#	mutating function
####################################################
 
x = rand(10); y = rand(10)

function foo!(x,y)
    @. x = -x
    @. y = -y
end
 



x = rand(10); y = rand(10)

function foo!(x,y)
    task_a = @spawn (@. x = -x)
    task_b = @spawn (@. y = -y)

    wait.((task_a, task_b))
end
 



x = rand(10); y = rand(10)

function foo!(x,y)
    @sync begin
        @spawn (@. x = -x)
        @spawn (@. y = -y)
    end    
end
 



############################################################################
#
#			MULTITHREADING OVERHEAD
#
############################################################################
 
####################################################
#	example with @spawn
####################################################
 
Random.seed!(1234)       #setting seed for reproducibility
x = rand(10_000_000)

function non_threaded(x)    
    a           = maximum(x)
    b           = sum(x)
    
    all_outputs = (a,b)
end
non_threaded(x)
 
foo(x) = maximum(x)
@ctime foo($x)
 
foo(x) = sum(x)
@ctime foo($x)
 
@ctime non_threaded($x)
 



Random.seed!(1234)       #setting seed for reproducibility
x = rand(10_000_000)

function multithreaded(x)    
    task_a      = @spawn maximum(x)
    task_b      = @spawn sum(x)
    
    all_tasks   = (task_a, task_b)
    all_outputs = fetch.(all_tasks)
end
multithreaded(x)
 
@ctime multithreaded($x)
 



# multithreading overhead
 
Random.seed!(1234)       #setting seed for reproducibility
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(1_000_000)

function foo(x)    
    a           = maximum(x)
    b           = sum(x)
    
    all_outputs = (a,b)
end
 
@ctime foo($x_small)
 
@ctime foo($x_medium)
 
@ctime foo($x_big)
 



Random.seed!(1234)       #setting seed for reproducibility
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(1_000_000)

function foo(x)    
    task_a      = @spawn maximum(x)
    task_b      = @spawn sum(x)
    
    all_tasks   = (task_a, task_b)
    all_outputs = fetch.(all_tasks)
end
 
@ctime foo($x_small)
 
@ctime foo($x_medium)
 
@ctime foo($x_big)
 
