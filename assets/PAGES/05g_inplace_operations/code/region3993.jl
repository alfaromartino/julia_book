x         = [1, 2, 3]    # Vector{Int64}

x[2:3]    = [3.0, 4]     # 3.0 is Float64 but accepts conversion
print_asis(x)   #hide