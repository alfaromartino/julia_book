length_vector = 500
repetitions   = 100_000                                     # repetitions in a loop

function foo(length_vector, repetitions)
    for _ in 1:repetitions
        fill(2, length_vector)                              # vector filled with 2s
    end
end

#@btime foo(ref($length_vector), ref($repetitions))