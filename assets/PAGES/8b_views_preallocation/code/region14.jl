using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

function prealloc_temp(x, y; output=similar(x), temp=similar(x))
    for i in eachindex(x)
        @. temp      = 2 * x
           output[i] = sum(temp) + x[i]        
    end

    return output
end



@btime prealloc_temp(ref($x));