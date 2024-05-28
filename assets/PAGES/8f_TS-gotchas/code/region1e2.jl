foo(β; x = β) = x

β = 1
@code_warntype foo(β)            #type stable