function foo()
    x = [2, 4, 6]

    for word in ["hello"]
        x = word             # `x` is reassigned
    end

    return x
end
print_asis(foo())     #hide