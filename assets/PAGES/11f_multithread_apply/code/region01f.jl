Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(10_000_000)

function foo(x)
    chunk_ranges    = index_chunks(x, n=nthreads())
    nr_strides      = 8
    partial_outputs = Matrix{Float64}(undef, nr_strides, length(chunk_ranges))

    @threads for (i, chunk) in enumerate(chunk_ranges)
        for j in chunk
            partial_outputs[1, i] += log(x[j])
        end
    end

    return sum(@view(partial_outputs[1, :]))
end
@ctime foo($x)  #hide