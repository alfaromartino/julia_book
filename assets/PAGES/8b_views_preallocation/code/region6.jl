length_vector = 500
repetitions   = 100_000                                     # repetitions in a for-loop

function foo(length_vector,repetitions)
    for _ in 1:repetitions
        zeros(Int64, length_vector)
    end
end

#@btime foo(ref($length_vector), ref($repetitions))