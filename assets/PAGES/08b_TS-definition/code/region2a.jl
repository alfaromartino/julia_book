function foo(x)
    y = (x < 0) ?  0  :  x
    
    y * 2
end
@code_warntype foo(1.0) #hide