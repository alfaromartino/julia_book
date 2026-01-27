function foo(x)
    y = (x < 0) ?  0  :  x    
    
    for i in 1:100
      y = y + i
    end
    
    return y
end
@code_warntype foo(1.0) #hide