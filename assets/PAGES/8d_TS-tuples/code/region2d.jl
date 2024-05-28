x  = Vector{Int64}(undef, 10)   # `x` is defined as Vector{Int64}
x .= 1.0                        # `x` is converted to `Int64` to respect type's definition

sum(x)          # hide
@code_warntype sum(x)           # type stable