include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Random, Base.Threads, ChunkSplitters, OhMyThreads, LoopVectorization, Polyester, Folds, FLoops, LazyArrays
 
############################################################################
#
#			USING MULTITHREADING NATIVE PACKAGE
#
############################################################################
 
# package Threads automatically imported when you start Julia

Threads.nthreads()
print_asis(Threads.nthreads()) #hide
 
using Base.Threads      # or `using .Threads`

nthreads()
print_asis(nthreads()) #hide
 
############################################################################
#
#			CONCURRENT NON-BLOCKING TASKS  (SPAWN)
#
############################################################################
 
####################################################
#	waiting for results
####################################################
 
x = rand(10); y = rand(10)

function foo(x)
    a = x .* -2
    b = x .*  2

    a,b
end
 
x = rand(10); y = rand(10)

function foo(x)
    task_a = @spawn x .* -2
    task_b = @spawn x .*  2

    a,b = fetch.((task_a, task_b))
end
 
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
 
####################################################
#	example with spawn
####################################################
 
Random.seed!(1234) #hide
x      = rand(10_000_000)
foo(x) = maximum(x)

@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x      = rand(10_000_000)
foo(x) = sum(x)

@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function non_threaded(x)    
    a           = maximum(x)
    b           = sum(x)
    
    all_outputs = (a,b)
end
non_threaded(x) #hide
 
@ctime non_threaded($x)
 
Random.seed!(1234) #hide
x = rand(10_000_000)

function multithreaded(x)    
    task_a      = @spawn maximum(x)
    task_b      = @spawn sum(x)
    
    all_tasks   = (task_a, task_b)
    all_outputs = fetch.(all_tasks)
end
multithreaded(x) #hide
 
@ctime multithreaded($x)
 
# multithreading overhead
 
Random.seed!(1234) #hide
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
 
Random.seed!(1234) #hide
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
 
# multithreading overhead - with more tasks
 
Random.seed!(1234) #hide
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(1_000_000)

function foo(x)    
    a           = maximum(x)
    b           = sum(x)
    c           = minimum(x)
    d           = prod(x)
    
    all_outputs = (a,b,c,d)
end
 
@ctime foo($x_small)
 
@ctime foo($x_medium)
 
@ctime foo($x_big)
 
Random.seed!(1234) #hide
x_small  = rand(    1_000)
x_medium = rand(  100_000)
x_big    = rand(1_000_000)

function foo(x)    
    task_a      = @spawn maximum(x)
    task_b      = @spawn sum(x)
    task_c      = @spawn minimum(x)
    task_d      = @spawn prod(x)
    
    all_tasks   = (task_a, task_b, task_c, task_d)
    all_outputs = fetch.(all_tasks)
end
 
@ctime foo($x_small)
 
@ctime foo($x_medium)
 
@ctime foo($x_big)
 
############################################################################
#
#			MULTITHREADED FOR-LOOPS
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
 
# typical application of `threads`
 
Random.seed!(1234) #hide
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
 
####################################################
#	increasing time per iteration
####################################################
 
function job(i; time_working)
    println("Iteration $i is on Thread $(threadid())")

    start_time = time()

    while time() - start_time < time_working
        1 + 1                  # compute `1+1` repeatedly during `time_working` seconds
    end    
end
 
function foo(nr_iterations)
    for i in 1:nr_iterations
      job(i; time_working = i)      
    end
end
foo(1); #hide
 
@ctime foo(4) #hide
 
function foo(nr_iterations)
    @threads for i in 1:nr_iterations
        job(i; time_working = i)        
    end
end
foo(1); #hide
 
@ctime foo(4) #hide
 
function foo(nr_iterations)
    @sync begin
        for i in 1:nr_iterations
            @spawn job(i; time_working = i)            
        end
    end
end
foo(1); #hide
 
@ctime foo(4) #hide
 
####################################################
#	same time per iteration
####################################################
 
function job(i; time_working)
    start_time = time()

    while time() - start_time < time_working
        1 + 1                  # compute `1+1` repeatedly during `time_working` seconds
    end    
end
 
function foo(nr_iterations)
    fixed_time = 1 / 1_000_000

    for i in 1:nr_iterations
      job(i; time_working = fixed_time)
    end
end
foo(1); #hide
GC.gc() ; #hide
 
@ctime foo(1_000_000) #hide
 
function foo(nr_iterations)
    fixed_time = 1 / 1_000_000

    @threads for i in 1:nr_iterations
        job(i; time_working = fixed_time)
    end
end
foo(1); #hide
GC.gc() ; #hide
 
@ctime foo(1_000_000) #hide
 
function foo(nr_iterations)
    fixed_time = 1 / 1_000_000

    @sync begin
        for i in 1:nr_iterations
            @spawn job(i; time_working = fixed_time)
        end
    end
end
foo(1); #hide
GC.gc() ; #hide
 
@ctime foo(1_000_000) #hide
 
####################################################
#	example with real operations
####################################################
 
# same time per iteration
 
Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    @threads for i in eachindex(x)
        log(x[i])
    end
end
foo(x); #hide
GC.gc() #hide
 
@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    @sync begin
        for i in eachindex(x)
            @spawn log(x[i])
        end
    end
end
foo(x); #hide
GC.gc() #hide
 
@ctime foo($x) #hide
 
# increasing time per iteration
 
Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    @threads for i in eachindex(x)
        sum(@~ log.(x[1:i]))
    end
end
foo(x); #hide
GC.gc() #hide
 
@ctime foo($x) #hide
 
Random.seed!(1234) #hide
x = rand(10_000)

function foo(x)
    @sync begin
        for i in eachindex(x)
            @spawn sum(@~ log.(x[1:i]))
        end
    end
end
foo(x); #hide
GC.gc() #hide
 
@ctime foo($x) #hide
 
