function foo()    
    x = 1
    
    return bar(x)
end

bar(x) = x

@code_warntype foo()      # type stable