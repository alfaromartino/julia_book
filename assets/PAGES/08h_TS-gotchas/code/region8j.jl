function foo()
    x            = 1
    x            = 1            # or 'x = x', or 'x = 2'    
        
    return bar(x)
end

bar(x) = x

@code_warntype foo()            # type stable