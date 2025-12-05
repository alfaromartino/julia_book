Random.seed!(1234) #hide
x = rand(10_000_000)

function compute!(output, x, chunk)
     @turbo for j in chunk 
        output[j] = log(x[j])
     end
end

function foo(x, nr_chunks)
    chunk_ranges = index_chunks(x, n=nr_chunks)
    output       = similar(x)

    @sync for chunk in chunk_ranges
        @spawn compute!(output, x, chunk)
    end

    return output
end