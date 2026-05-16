function foo(β)
    rescale_parameter(β)  =  β / 10
    x(β)                  =  2 * rescale_parameter(β)  
    
    return x(β)
end

@code_warntype foo(1)       # type stable