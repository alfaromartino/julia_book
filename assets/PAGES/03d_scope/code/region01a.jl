x = "hello"

function foo(x)        # 'x' is local, unrelated to 'x = hello' above
    y = x + 2          # 'y' is local, 'x' refers to the function argument 
    
    return x,y
end