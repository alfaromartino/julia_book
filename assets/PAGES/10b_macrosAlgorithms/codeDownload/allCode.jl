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
#   AUXILIARS FOR DISPLAYING RESULTS
############################################################################
# you can alternatively use "println" or "display"
print_asis(x)    = show(IOContext(stdout, :limit => true, :displaysize =>(9,100)), MIME("text/plain"), x)
print_compact(x) = show(IOContext(stdout, :limit => true, :displaysize =>(9,6), :compact => true), MIME("text/plain"), x)


############################################################################
#
#			START OF THE CODE
#
############################################################################
 
# necessary packages for this file
using Random
 
############################################################################
#
#			@VIEWS as an example of macro that simplifies code
#
############################################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    x1 = view(x, x .> 0.7)
    x2 = view(x, x .< 0.5)
    x3 = view(x, 1:500)
    x4 = view(x, 501:1_000)

    x1, x2, x3, x4
end
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

@views function foo(x)
    x1 = x[x .> 0.7]
    x2 = x[x .< 0.5]
    x3 = x[1:500] 
    x4 = x[501:1_000]

    x1, x2, x3, x4
end
 



############################################################################
#
#			@INBOUNDS
#
############################################################################
 
####################################################
#	syntax
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(100_000)

function foo(x)
    output = similar(x)   

    for i in eachindex(x)
        output[i] = x[i] * 2
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(100_000)

function foo(x)
    output = similar(x)   

    @inbounds for i in eachindex(x)
        output[i] = x[i] * 2
    end

    return output
end
@ctime foo($x)
 



# equivalence
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    output = 0.    

    @inbounds for i in eachindex(x)
                  a       = log(x[i])
                  b       = exp(x[i])
                  output += a / b
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    output = 0.    

    for i in eachindex(x)
        @inbounds a       = log(x[i])
        @inbounds b       = exp(x[i])
                  output += a / b
    end

    return output
end
@ctime foo($x)
 



####################################################
#	@inbounds could be applied automatically
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1_000)

function foo(x)
    output = 0.

    @inbounds for i in eachindex(x)
        output += log(x[i])
    end

    return output
end
@ctime foo($x)
 



####################################################
#	@inbounds isn't necessarily applied automatically and can entail a substantial time difference
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
v,w,x,y = (rand(100_000) for _ in 1:4)       # it assigns random vectors to v,w,x,y

function foo(v, w, x, y)
    output = 0.0

    for i in 2:length(v)-1
        output += v[i-1] / v[i+1] / w[i-1] * w[i+1] + x[i-1] * x[i+1] / y[i-1] * y[i+1]
    end

    return output
end
@ctime foo($v,$w,$x,$y)
 



Random.seed!(123)       #setting seed for reproducibility
v,w,x,y = (rand(100_000) for _ in 1:4)       # it assigns random vectors to v,w,x,y

function foo(v, w, x, y)
    output = 0.0

    @inbounds for i in 2:length(v)-1
        output += v[i-1] / v[i+1] / w[i-1] * w[i+1] + x[i-1] * x[i+1] / y[i-1] * y[i+1]
    end

    return output
end
@ctime foo($v,$w,$x,$y)
 



####################################################
#	splitting @inbounds is possible
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
v,w,x,y = (rand(100_000) for _ in 1:4)        # it assigns random vectors to v,w,x,y

function foo(v,w,x,y)
    output = 0.0

    @inbounds for i in 2:length(v)-1
                  term1   = v[i-1] / v[i+1] / w[i-1] * w[i+1]
                  term2   = x[i-1] * x[i+1] / y[i-1] * y[i+1]
        
                  output += term1 + term2
    end

    return output
end
@ctime foo($v,$w,$x,$y)
 



Random.seed!(123)       #setting seed for reproducibility
v,w,x,y = (rand(100_000) for _ in 1:4)        # it assigns random vectors to v,w,x,y

function foo(v,w,x,y)
    output = 0.0

    for i in 2:length(v)-1
        @inbounds term1   = v[i-1] / v[i+1] / w[i-1] * w[i+1]
        @inbounds term2   = x[i-1] * x[i+1] / y[i-1] * y[i+1]

                  output += term1 + term2
    end

    return output
end
@ctime foo($v,$w,$x,$y)
 



####################################################
#	remark - about using macros for functions in for-loops
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
v,w,x,y = (rand(100_000) for _ in 1:4) # it assigns random vectors to v, w, x, y



function foo(v,w,x,y)
    output = 0.0

    for i in 2:length(v)-1
        output += v[i-1] / v[i+1] / w[i-1] * w[i+1] + 
                  x[i-1] * x[i+1] / y[i-1] * y[i+1]
    end

    return output
end
@ctime foo($v,$w,$x,$y)
 



Random.seed!(123)       #setting seed for reproducibility
v,w,x,y = (rand(100_000) for _ in 1:4) # it assigns random vectors to v, w, x, y
compute(i, v,w,x,y) = v[i-1] / v[i+1] / w[i-1] * w[i+1] + 
                      x[i-1] * x[i+1] / y[i-1] * y[i+1]

function foo(v,w,x,y)
    output = 0.0

    @inbounds for i in 2:length(v)-1
        output += compute(i, v,w,x,y)

    end

    return output
end
@ctime foo($v,$w,$x,$y)
 



Random.seed!(123)       #setting seed for reproducibility
v,w,x,y = (rand(100_000) for _ in 1:4) # it assigns random vectors to v, w, x, y



function foo(v,w,x,y)
    output = 0.0

    @inbounds for i in 2:length(v)-1
        output += v[i-1] / v[i+1] / w[i-1] * w[i+1] + 
                  x[i-1] * x[i+1] / y[i-1] * y[i+1]
    end

    return output
end
@ctime foo($v,$w,$x,$y)
 



############################################################################
#
#			SIMD (SINGLE INSTRUCTION, MULTIPLE DATA)
#
############################################################################
 
####################################################
#	@simd sometimes it's not automatic
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo(x)
    output = 0.

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo(x)
    output = 0.

    @inbounds @simd for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x)
 



####################################################
#	@simd could be applied automatically
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo!(x)
    for i in eachindex(x)
        x[i] = x[i] * 2
    end
end
@ctime foo!($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo!(x)
    @inbounds @simd for i in eachindex(x)
        x[i] = x[i] * 2
    end
end
@ctime foo!($x)
 



####################################################
#	@simd could be disregarded
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo(x)
    output = similar(x)

    for i in eachindex(x)
        output[i] = if (200_000 > i > 100_000)
                        x[i] * 1.1
                    else
                        x[i] * 1.2
                    end
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo(x)
    output = similar(x)

    @simd for i in eachindex(x)
        output[i] = if (200_000 > i > 100_000)
                        x[i] * 1.1
                    else
                        x[i] * 1.2
                    end
    end

    return output
end
@ctime foo($x)
 



####################################################
#	Simpler Example
####################################################
 
Random.seed!(123)       #setting seed for reproducibility
x = rand(1:10, 2_000_000)

function foo(x)
    output = 0

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(1:10, 2_000_000)

function foo(x)
    output = 0

    @simd for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo(x)
    output = 0.0

    for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x)
 



Random.seed!(123)       #setting seed for reproducibility
x = rand(2_000_000)

function foo(x)
    output = 0.0

    @simd for i in eachindex(x)
        output += x[i]
    end

    return output
end
@ctime foo($x)
 
