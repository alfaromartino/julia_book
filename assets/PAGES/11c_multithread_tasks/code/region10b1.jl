Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(10_000_000)

function multithreaded(x)    
    task_a      = @spawn maximum(x)
    task_b      = @spawn sum(x)
    
    all_tasks   = (task_a, task_b)
    all_outputs = fetch.(all_tasks)
end
multithreaded(x) #hide