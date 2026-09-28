Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(1_000_000)

function foo(x)
    output = similar(x)
    
    @tasks for i in eachindex(x)
        @set chunksize = length(x) ÷ nthreads()     # size that evenly distributes work
            output[i] = log(x[i])
    end

    return output
end
@ctime foo($x) #hide