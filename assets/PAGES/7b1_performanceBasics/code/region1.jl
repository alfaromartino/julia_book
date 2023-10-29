using BenchmarkTools
ref(x) = (Ref(x))[]

#barrier functions, const, zero, splitting functions
####################################################
#	EXAMPLE 1A
####################################################
function example1(x)
    y = (x < 0) ?  0  :  x
    
    return [y / i for i in 1:100]
end

@code_warntype example1(1)
@code_warntype example1(1.)