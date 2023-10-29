using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100); output = similar(x); temp = similar(x)

update_temp!(x, temp, i) = (@. temp = x > x[i])

function prealloc_temp(x, output, temp)    
    for i in eachindex(x)
           update_temp!(x, temp, i)
           output[i] = sum(temp)
    end
    return output
end

replicate(x, output, temp) = [prealloc_temp(x, output, temp) for _ in 1:1_000]

@btime replicate(ref($x), ref($output), ref($temp))