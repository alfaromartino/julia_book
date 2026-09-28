z5::Vector{Any}    = [1, 2, 3]

sum(z5)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Any`
@ctime sum(z5)   #hide