
#using DataFrames,BenchmarkTools, FLoops, LoopVectorization, FastBroadcast, Formatting, ThreadsX, Strided, Distributions, Random, Pipe, BrowseTables
using DataFrames, BenchmarkTools, BrowseTables, Distributions, Random, Pipe
browse(x) = open_html_table(x)


# to test a complex function 
foo(x,y) = x / y * 100 + (x^2 + y^2) / y + log(x) + y * exp(x)
#using Random ; Random.seed!(123)        #Setting the seed for reproducibility

##############################################################################
#                       INTEGERS AND FLOATS
##############################################################################
function foo(x)
    y = x + 1
    (rand() < 0.5) ? (y = y / 2) : (y = y * 2)
    
    return y
end

@code_warntype foo(1)       # type unstable
@code_warntype foo(1)       # type unstable
@btime foo(1.0)     # type stable
@btime foo(1)     # type stable



### SPEED TEST
using Random ; Random.seed!(123)        #Setting the seed for reproducibility
nr_elements   = 1
repetitions   = 100_000
random_vector = rand(nr_elements, repetitions)
random_list   = vec(random_vector)

function test(random_list, repetitions)
    for i in 1:repetitions
        x = random_list[i]
        foo(x)
    end    
end

@btime test(1:$repetitions, $repetitions)
@btime test($random_list, $repetitions)



##############################################################################
#                       BE CAREFUL WITH FUNCTION BARRIERS
##############################################################################



##############################################################################
#                       BE CAREFUL WITH KEYWORD ARGUMENTS
##############################################################################


### ISSUE
parameter = 3
array     = [1.0, 2.0, 3.0]

foo(x; β = parameter) = x .* β

@code_warntype foo(array)                   # type unstable
@code_warntype foo(array; β = parameter)    # type stable



### FIX 1 - MY PREFERRED CHOICE
array                          = [1, 2]
foo(x, nt)                     = sum(x .+ nt.β)

param  = 3
nt     = (; β = param)
@code_warntype foo(array,nt)    # type stable, equals #9

param  = 3.0
nt     = (; β = param)
@code_warntype foo(array,nt)    # type stable, equals #9.0


### FIX 2 - FLEXIBLE
array                          = [1, 2]
foo(x; β = param())            = sum(x .* β) 

param() = 3                     # this acts as a `const` value
@code_warntype foo(array)       # type stable, equals #9.0

param() = 3.0
@code_warntype foo(array)       # type stable, equals #9.0



### FIX 3 - NOT FLEXIBLE
array                          = [1, 2]
foo(x; β::Float64 = parameter) =  sum(x .* β) # it only accepts `Float64` for `β`

parameter = 3.0
@code_warntype foo(array)       # type stable, equals #9.0

parameter = 3
foo(array)                      # error





##############################################################################
#                       BE CAREFUL WITH CLOSURES
##############################################################################

# ISSUE 1
function foo()
    β     = 1
    β     = 1   # or `β = β`or `β = 2`, or ...
    baz() = β 

    return baz()
end

@code_warntype foo() #type unstable


# ISSUE 2
# type annotations do not help
function foo()
    β::Int64     =  1                           
    β            =  1
    baz()::Int64 =  β::Int64   

    return baz()
end

@code_warntype foo(1)   # type unstable




##############################################################################
#                       BUT NO ONE RIGHTS CODE LIKE THAT
##############################################################################
#CONSEQUENCE 1
#be careful with loops + closures    
    function foo(x)
        β = 0           # initialize `β`, you can even write `β::Int64 = 0`
        for i in 1:10
            β += i      # equivalent to `β = β + i`, e.g. cumulative function
        end

        inner_foo(x) = x + β 
        
        return inner_foo(x)
    end
    @code_warntype foo(1)

        #be careful with transforming variables
    function foo(x,β)
        # transform `β` to use the absolute value
        (β < 0) && (β = -β)    # also type unstable with `(2<1)` && (β=β)`

        inner_foo(x) = x + β 

        return inner_foo(x)
    end
    @code_warntype foo(1,2)


    function foo(array, β)
        (β < 0) && (β = - β)                # transform `beta` to use the absolute value
        
        filter((x -> x > β), array)         # keep elements in `array` that are greater than beta
    end
    
    @code_warntype foo([1,10], 2)           # type unstable
    

    ####### SOLUTION
    function foo(x,β)
        # transform parameter `β`
        transf(β)    =  2 * β
        β            =  transf(β)

        inner_foo(x) =  x + β 

        return inner_foo(x)
    end
    @code_warntype foo(1,2)


    function foo(x,β)
        # transform `β` using an outer function
        # use `abs` instead, which is a function defined outside
        β             =  abs(β)
        inner_foo(x)  =  x + β 

        return inner_foo(x)
    end
    @code_warntype foo(1,2)




#CONSEQUENCE 2
# the order in which you define functions matters within a functions
    function foo(x)
        baz(x) = x + β 
        β = 0
        return baz(x)
    end
    @code_warntype foo(1)

    #but
    function foo(x)
        β = 0
        baz(x) = x + β 
        return baz(x)
    end
    @code_warntype foo(1)

    # be careful with wrapping all you code into a function to improve performance

#CONSEQUENCE 3
# the order in which you define functions matters within a functions 
    function x_transformation(β)
        x(β)                  =  rescale_parameter(β) * 2 # the variable you're interested in 
        rescale_parameter(β)  =  β - 1                     # some transformation of a parameter

        return x(β)     # the price transformation
    end
    @code_warntype x_transformation(1) # type unstable

    #but
    function x_transformation(β)
        rescale_parameter(β)  =  β - 1                    # some transformation of a parameter
        x(β)                  =  rescale_parameter(β) * 2 # the variable you're interested in 
        
        return x(β)     # the price transformation
    end

    @code_warntype x_transformation(1) # type stable


    
##############################################################################
#                       FIXING CLOSURES
##############################################################################

## FIX 1
#  define the function outside, avoiding closures
    baz(x,β) =  x * β 
    function foo(x)
        β = 1
        β = 2    
        return baz(x,β)
    end

    @code_warntype foo(1)

## FIX 2 
# recommended only for variables, not for functions. If the problem is due to a function, fix 1 is preferred
    function foo(x)
        β = 1
        β = 2
        baz(x,β) =  x * β 

        return baz(x,β)
    end

    @code_warntype foo(1)



## FIX 3 - don't redefine variables
# avoid redefining variables
function foo(x)    
    β = 2
    baz(x) =  x * β 

    return baz(x)
end

@code_warntype foo(1)


## FIX 4 - let block but performnce hit
function foo(x)
    β = 1    
    let β=β                 # when you define `β`in `foo` does not matter now
        β = 2
        baz(x) =  x * β 
    end
    
    return baz(x)
end

@code_warntype foo(1) #type stable


##############################################################################
#                       EXAMPLE FROM ECONOMICS
##############################################################################

# CONSEQUENCE 3
# the order in which you define functions matters within a functions

    # TYPE-UNSTABLE FUNCTION
    # even annotating the type of `β` does not help
    function price_transformation1(β)
        price(β) = elast(β) / (elast(β) - 1) # the variable you're interested in 
        elast(β) = β - 1                     # some transformation of a parameter

        output   = price(β)^(1-elast(β))     # the price transformation
        return output
    end

    @code_warntype price_transformation1(3)   #type unstable


    # TYPE-STABLE FUNCTION
    # define function "elast" first
    function price_transformation2(β)
        elast(β) = β - 1
        price(β) = elast(β) / (elast(β) - 1) 

        output   = price(β)^(1-elast(β))
        return output
    end
    @code_warntype  price_transformation2(3)     #type stable


    # TYPE-STABLE FUNCTION
    # avoid closures
    price(β)                 = elast(β) / (elast(β) - 1) 
    elast(β)                 = β - 1    
    price_transformation3(β) = price(β)^(1-elast(β))
        
    @code_warntype  price_transformation3(3)     #type stable

    # TYPE-STABLE FUNCTION
    # include `elast` as argument
    function price_transformation4(β)
        elast(β)       = β - 1
        price(β,elast) = elast(β) / (elast(β) - 1)  

        output   = price(β)^(1-elast(β))
        return output
    end

    @code_warntype  price_transformation4(3)     #type stable
