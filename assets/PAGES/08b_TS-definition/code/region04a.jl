function foo()
    for i in 1:100
        i
    end
end
@code_warntype foo() #hide