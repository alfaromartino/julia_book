using Random; Random.seed!(123)       #setting the seed for reproducibility #hide
x = rand(100)

update_temp!(x, temp) = (@. temp = 2 * x)
    
function compute_output(x, length_output)
    output = Vector{Float64}(undef, length_output)
    temp   = similar(x)

    for i in 1:length_output
        update_temp!(x, temp)
        output[i] = sum(temp) + i
    end

    return output
end

@btime compute_output(ref($x), ref($length_output))