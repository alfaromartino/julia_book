Random.seed!(123)       #setting seed for reproducibility #hide
nr_days    = 2
nr_workers = 1_000_000

scores     = rand(nr_days,nr_workers)




function foo(score; temp = Vector{Float64}(undef, nr_days))
    for i in eachindex(score)
        temp[i] = score[i] > 0.5
    end

    return temp
end

@views repeated_call(scores) = [sum(foo(scores[:,j])) for j in axes(scores,2)]
@ctime repeated_call($scores) #hide