############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
    # uncomment if you don't have the package installed
using FastBenchmark
    

############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Random
 
############################################################################
#
#			SIMD: CONTIGUOUS ACCESS AND UNIT STRIDES
#
############################################################################
 
############################################################################
#
#			REVIEW OF INDEXING APPROACHES
#
############################################################################
 
x         = [10, 20, 30]

indices   = sortperm(x)
elements  = x[indices]    # equivalent to `sort(x)`
 
println(indices)
 
println(elements)
 



x         = [2, 3, 4, 5, 6]

indices_1 = 1:length(x)         # unit strides, equivalent to 1:1:length(x)
indices_2 = 1:2:length(x)       # strides two
 
println(collect(indices_1))
 
println(collect(indices_2))
 



x         = [20, 10, 30]

indices   = x .> 15
elements  = x[indices]
 
println(indices)
 
println(elements)
 



############################################################################
#
#			BENEFITS OF SEQUENTIAL ACCESS
#
############################################################################
 
####################################################
#	illustrating each benefit in isolation
####################################################
 
####################################################
#	case 1
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)
y = @view x[1:2:length(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)
y = @view x[1:2:length(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)
y = x[1:2:length(x)]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000_000)
y = x[1:2:length(x)]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



####################################################
#	case 2
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = sortperm(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = sortperm(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = sortperm(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = sortperm(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



####################################################
#	case 3
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = x .> 0.5
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)

indices = x .> 0.5
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



############################################################################
#
#			COPIES VS VIEWS: TOTAL EFFECTS
#
############################################################################
 
####################################################
#	ultimately a race horse between not copying data vs SIMD efficiency
####################################################
 
# example where view is faster
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($x, $indices)
 



# example where copy is faster
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output = 0.0

    @simd for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output = 0.0

    @simd for a in y
        output += a^(3/2)
    end

    return output
end
@ctime foo($x, $indices)
 



####################################################
#	special cases
####################################################
 
# case 1
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)

indices = 1:length(x)
y       = @view x[indices]

function foo(y)
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(1_000_000)

indices = 1:length(x)
y       = x[indices]

function foo(y)    
    output = 0.0

    @simd for a in y
        output += a
    end

    return output
end
@ctime foo($y)
 



# case 2
 
Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = @view x[indices]
    output1, output2, output3 = (0.0 for _ in 1:3)

    @simd for a in y
        output1 += a^(3/2)
        output2 += a / 3
        output3 += a * 2.5
    end

    return output1, output2, output3
end
@ctime foo($x, $indices)
 



Random.seed!(123)       #setting seed for reproducibility
x       = rand(5_000_000)
indices = sortperm(x)

function foo(x, indices)
    y      = x[indices]
    output1, output2, output3 = (0.0 for _ in 1:3)

    @simd for a in y
        output1 += a^(3/2)
        output2 += a / 3
        output3 += a * 2.5
    end

    return output1, output2, output3
end
@ctime foo($x, $indices)
 



