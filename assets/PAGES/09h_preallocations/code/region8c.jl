Random.seed!(123)       #setting seed for reproducibility #hide
nr_days            = 30
score              = rand(nr_days)

function performance(score; target=similar(score))
    

    for i in eachindex(score)
        target[i] = score[i] > 0.5
    end

    return target
end
@ctime performance($score) #hide