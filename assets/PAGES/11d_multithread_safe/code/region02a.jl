function foo()
    output = 0

    for i in 1:2
        sleep(1/i)
        output = i
    end

    return output
end
print_asis(foo()) #hide