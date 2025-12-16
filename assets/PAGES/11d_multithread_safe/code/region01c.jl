function foo()
    output = Vector{Int}(undef,2)
    

    @threads for i in 1:2
        temp      = i; sleep(i)
        output[i] = temp
    end

    return output
end
print_asis(foo()) #hide