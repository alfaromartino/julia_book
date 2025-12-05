function foo()
    x = [0, 0, 0]

    job!(x) |> schedule             # define job, start execution, don't wait for job to be done

    return sum(x)
end

output = foo()
println("the value stored in `output` is $(output)")