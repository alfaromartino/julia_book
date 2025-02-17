# Description of job
function job!(x)
    for i in 1:3
        sleep(1)     # do nothing for 1 second
        x[i] = 1     # mutate x[i]

        println("`x` at this moment is $x")
    end
end

# Execution of job
function foo()
    x = [0, 0, 0]

    job!(x)          # slowly mutate `x`

    return sum(x)
end

output = foo()
println("the value stored in `output` is $(output)")