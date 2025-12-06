z = 2

function foo(x)                 
    y = x + z          # 'x' refers to the function argument, 'z' refers to the global

    return x,y,z
end