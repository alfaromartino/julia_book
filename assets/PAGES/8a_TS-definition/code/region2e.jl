x5::Vector{Number} = [1, 2, 3]

sum(x5)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Number`
@btime sum(x5)   # hide