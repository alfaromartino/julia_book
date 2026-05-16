x = 2

function foo(x)
    task_a = @spawn x * -2
    task_b = @spawn x *  2
    
    a,b    = fetch.((task_a, task_b))
end