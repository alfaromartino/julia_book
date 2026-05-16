include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
using Base.Threads
 
############################################################################
#
#			SECTION: "INTRODUCTION TO MULTITHREADING"
#
############################################################################
 
############################################################################
#
#			NATURE OF COMPUTATIONS
#
############################################################################
 
####################################################
#	task A -> execute operation that B needs as input
#	task B -> work with A's output
####################################################
 
job_A()  = 1 + 1
job_B(A) = 2 + A

function foo()
    A = job_A()
    B = job_B(A)

    return A,B
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
job_A()  = 1 + 1
job_B()  = 2 + 2

function foo()
    A = job_A()
    B = job_B()

    return A,B
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			TASKS AND THREADS
#
############################################################################
 
####################################################
#	task A -> wait (do nothing) until message arrives
#	task B -> sum 1 + 1 during `time_working`
####################################################
 
function job_A(time_working)
    sleep(time_working)        # do nothing (waiting for some delivery in the example)

    println("A completed his task")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function job_B(time_working)
    start_time = time()

    while time() - start_time < time_working
        1 + 1                  # compute `1+1` repeatedly during `time_working` seconds
    end

    println("B completed his task")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# defining jobs as tasks
 
A = @task job_A(2)      # A's task takes 2 seconds
B = @task job_B(1)      # B's task takes 1 second
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			SEQUENTIAL AND CONCURRENT COMPUTATIONS
#
############################################################################
 
# sequentially (Julia's standard execution)
 
A = job_A(2)            # A's task takes 2 seconds
B = job_B(1)            # B's task takes 1 second
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# sequential computation (default in Julia)
 
A = @task job_A(2)      # A's task takes 2 seconds
B = @task job_B(1)      # B's task takes 1 second

schedule(A) |> wait
schedule(B) |> wait
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# concurrent computation
 
A = @task job_A(2)      # A's task takes 2 seconds
B = @task job_B(1)      # B's task takes 1 second

(schedule(A), schedule(B)) .|> wait
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	task A -> sum 1 + 1 during `time_working`
#	task B -> sum 1 + 1 during `time_working`
####################################################
 
function job(name_worker, time_working)
    start_time = time()

    while time() - start_time < time_working
        1 + 1                  # compute `1+1` repeatedly during `time_working` seconds
    end

    println("$name_worker completed his task")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# sequentially (default in Julia)
 
function schedule_of_tasks()
    A = @task job("A", 2)      # A's task takes 2 seconds
    B = @task job("B", 1)      # B's task takes 1 second

    schedule(A) |> wait
    schedule(B) |> wait
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
#concurrently
 
function schedule_of_tasks()
    A = @task job("A", 2)      # A's task takes 2 seconds
    B = @task job("B", 1)      # B's task takes 1 second

    schedule(A)
    schedule(B)
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function schedule_of_tasks()
    A = @task job("A", 2)      # A's task takes 2 seconds
    B = @task job("B", 1)      # B's task takes 1 second

    (schedule(A), schedule(B)) .|> wait
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			MULTITHREADING
#
############################################################################
 
####################################################
#	EXECUTE CODE BELOW ONLY AFTER ENABLING MULTIPLE THREADS!!!
####################################################
 
####################################################
#	task A -> sum 1 + 1 during `time_working`
#	task B -> sum 1 + 1 during `time_working`
####################################################
 
function job(name_worker, time_working)
    start_time = time()

    while time() - start_time < time_working
        1 + 1                  # compute `1+1` repeatedly during `time_working` seconds
    end

    println("$name_worker completed his task")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# sequentially (default in Julia)
 
function schedule_of_tasks()
    A = @task job("A", 2)                         # A's task takes 2 seconds
    B = @task job("B", 1)                         # B's task takes 1 second

    schedule(A) |> wait
    schedule(B) |> wait
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
#concurrently
 
function schedule_of_tasks()
    A = @task job("A", 2) ; A.sticky = false      # A's task takes 2 seconds
    B = @task job("B", 1) ; B.sticky = false      # B's task takes 1 second

    (schedule(A), schedule(B)) .|> wait
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			MULTITHREADED CODE
#
############################################################################
 
####################################################
#	EXECUTE CODE BELOW ONLY AFTER ENABLING MULTIPLE THREADS!!!
####################################################
 
####################################################
#	task A -> sum 1 + 1 during `time_working`
#	task B -> sum 1 + 1 during `time_working`
####################################################
 
function job(name_worker, time_working)
    start_time = time()

    while time() - start_time < time_working
        1 + 1                  # compute `1+1` repeatedly during `time_working` seconds
    end

    println("$name_worker completed his task")
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# sequentially (default in Julia)
 
function schedule_of_tasks()
    A = job("A", 2)             # A's task takes 2 seconds
    B = job("B", 1)             # B's task takes 1 second
end

@ctime schedule_of_tasks() #hide
 
# sequentially (default in Julia)
 
function schedule_of_tasks()
    A = @spawn job("A", 2)      # A's task takes 2 seconds
    B = @spawn job("B", 1)      # B's task takes 1 second

    (A,B) .|> wait
end

@ctime schedule_of_tasks() #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#			THE IMPORTANCE OF WAITING FOR THE RESULTS
#
############################################################################
 
# default Julia
 
# Description of job
function job!(x)
    for i in 1:3
        sleep(1)     # do nothing for 1 second
        x[i] = 1     # mutate x[i]

        println("`x` at this moment is $x")
    end
end

# Execution of job
function foo()
    x = [0, 0, 0]

    job!(x)          # slowly mutate `x`

    return sum(x)
end

output = foo()
println("the value stored in `output` is $(output)")
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# definition of task with result displayed
 
function job!(x)
    @task begin
        for i in 1:3
            sleep(1)    # do nothing for 1 second
            x[i] = 1    # mutate x[i]

            println("`x` at this moment is $x")
        end
    end
end
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
function foo()
    x = [0, 0, 0]

    job!(x) |> schedule             # define job, start execution, don't wait for job to be done

    return sum(x)
end

output = foo()
println("the value stored in `output` is $(output)")
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# waiting
 
function foo()
    x = [0, 0, 0]

    job!(x) |> schedule |> wait     # define job, start execution, only continue when finished

    return sum(x)
end

output = foo()
println("the value stored in `output` is $(output)")
 
