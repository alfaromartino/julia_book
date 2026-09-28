nr_days            = 30
score              = rand(nr_days)

performance(score) = score .> 0.5

function performance(score; output = similar(score))
    for i in eachindex(score)
        output[i] = score[i] > 0.5
    end

    return output
end

performance_in_a_loop(x) = [sum(foo(x)) for _ in 1:100]
@ctime performance_in_a_loop($x) #hide