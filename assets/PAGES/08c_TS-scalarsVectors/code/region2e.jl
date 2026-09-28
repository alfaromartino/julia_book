z4::Vector{Number} = [1, 2, 3]

sum(z4)             # type UNSTABLE -> `sum` must consider all possible subtypes of `Number`
@ctime sum(z4)   #hide