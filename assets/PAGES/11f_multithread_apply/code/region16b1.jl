Random.seed!(1234)       #setting seed for reproducibility #hide
x = rand(10_000_000)

function foo(x)
    chunk_ranges    = index_chunks(x, n=nthreads())
    partial_outputs = Vector{Float64}(undef, length(chunk_ranges))
    
    @threads for (i,chunk) in enumerate(chunk_ranges)
        partial_outputs[i] = sum(@view(x[chunk]))
    end
    
    return sum(partial_outputs)
end
print_asis(foo(x)) #hide