function foo(x)
    β = 0                      # or 'β::Int64 = 0'
    for i in 1:10
        β = β + i              # equivalent to 'β += i'
    end

    bar() = x + β              # or 'bar(x) = x + β'

    return bar()
end

@code_warntype foo(1)          # type UNSTABLE