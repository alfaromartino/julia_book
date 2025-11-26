x  = [1,2,3]
sx = SVector(x...)

#sx[1] = 0          # ERROR: setindex!(::SVector{3, Int64}, value, ::Int) is not defined.