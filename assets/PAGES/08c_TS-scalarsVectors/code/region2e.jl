z5::Vector{Number} = [1, 2, 3]

sum(z5)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Number`
@ctime sum(z5)   #hide