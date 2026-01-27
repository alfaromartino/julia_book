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
using Random, LoopVectorization
 
############################################################################
#
#			SECTION: "SIMD PACKAGES"
#
############################################################################
 
############################################################################
#
#			CAVEATS ABOUT IMPROPER USE OF @turbo
#
############################################################################
 
x = [0.1, 0.2, 0.3]

function foo!(x)
    for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x)
println(x)
 



x = [0.1, 0.2, 0.3]

function foo!(x)
    @inbounds @simd for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x)
println(x)
 



x = [0.1, 0.2, 0.3]

function foo!(x)
    @turbo for i in 2:length(x)
        x[i] = x[i-1] + x[i]
    end
end
foo!(x)
println(x)
 



############################################################################
#
#			SAFE APPLICATIONS OF @turbo
#
############################################################################
 
####################################################
#	independent iterations
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

foo(x)         = @turbo calculation.(x)
    
@ctime foo($x)
 



####################################################
#	reductions
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    @inbounds @simd for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a * 0.1 + a^2 * 0.2 - a^3 * 0.3 - a^4 * 0.4

function foo(x)
    output     = 0.0
    
    @turbo for i in eachindex(x)
        output += calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



############################################################################
#
#			SPECIAL FUNCTIONS
#
############################################################################
 
####################################################
#	LOGARITHMIC
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = log(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = log(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 



####################################################
#	EXPONENTIAL
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = exp(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = exp(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 



####################################################
#	POWER FUNCTIONS
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a^4

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = a^4

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 



# power functions includes calls to other function
 
Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sqrt(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sqrt(a)

foo(x) = @turbo calculation.(x)    
@ctime foo($x)
 



####################################################
#	TRIGONOMETRIC FUNCTIONS
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    @inbounds @simd for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sin(a)

function foo(x)
    output     = similar(x)
    
    @turbo for i in eachindex(x)
        output[i] = calculation(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x              = rand(1_000_000)
calculation(a) = sin(a)

foo(x)         = @turbo calculation.(x)
@ctime foo($x)
 
