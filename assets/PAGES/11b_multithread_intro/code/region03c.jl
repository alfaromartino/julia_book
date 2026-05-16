function foo()
    x = [0, 0, 0]

    job!(x) |> schedule |> wait     # define job, start execution, only continue when finished

    return sum(x)
end

output = foo()
println("the value stored in `output` is $(output)")