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