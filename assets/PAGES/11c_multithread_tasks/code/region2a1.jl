Random.seed!(1234) #hide
# package Threads automatically imported when you start Julia
x = rand(1_000)

function foo(x)
    output = similar(x)

    Threads.@threads for i in eachindex(x)
        output[i] = log(x[i])
    end

    return sum(output)
end
print_asis(foo(x)) #hide