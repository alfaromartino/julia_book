function foo(n)
    if n == 0 
        () 
    else
        (n, foo(n-1)...)
    end
end
# foo(50_000) # ERROR: StackOverflowError #hide