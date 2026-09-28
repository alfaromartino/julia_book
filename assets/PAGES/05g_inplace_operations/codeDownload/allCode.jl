############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    It provides the same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. 
        e.g., `@ctime foo($x)` for timing `foo(x)` =#

# uncomment the following if you don't have the package for @ctime installed
    # import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git")
using FastBenchmark
 
############################################################################
#
#			        SECTION: "IN-PLACE OPERATIONS"
#
############################################################################
 
############################################################################
#
#   MUTATIONS VIA COLLECTIONS
#
############################################################################
 
# slicing
 
x         = [1, 2, 3]

x[2:end]  = [20, 30]
println(x)
 



x         = [1, 2, 3]

x[x .≥ 2] = [20, 30]
println(x)
 



# updating
 
x         = [1, 2, 3]

x[2:end]  = [x[i] * 10 for i in 2:length(x)]
println(x)
 



x         = [1, 2, 3]

x[x .≥ 2] = x[x .≥ 2] .* 10
println(x)
 



# single-element slice
 
x         = [1, 2, 3]

x[3]      = 30
println(x)
 



####################################################
#	WARNING: vectors can only be mutated by objects of the same type
####################################################
 
x         = [1, 2, 3]    # Vector{Int64}

# x[2:3]    = [3.5, 4]     #ERROR # 3.5 is Float64
 



x         = [1, 2, 3]    # Vector{Int64}

x[2:3]    = [3.0, 4]     # 3.0 is Float64, but accepts conversion to Int64
println(x)
 
############################################################################
#
#   MUTATION VIA FOR-LOOPS
#
############################################################################
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements


for i in eachindex(x)
    x[i] = 0
end
println(x)
 



y = [1, 2, 3]
x = similar(y)               # `x` replicates the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = 0
end
println(x)
 



x     = zeros(3)
slice = view(x, 2:3)

for i in eachindex(slice)
    slice[i] = 1
end
println(x)
 



# via for-loop
 
x     = zeros(3)


for i in 2:3
    x[i] = 1
end
println(x)
 



x    = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements

for i in eachindex(x)
    x[i] = 0
end
println(x)
 
x    = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements

x[1] = 0
x[2] = 0
x[3] = 0
println(x)
 
############################################################################
#
#	MUTATION VIA .=
#
############################################################################
 
####################################################
#	vector on the RHS
####################################################
 
x       = [3, 4, 5]

x[1:2] .= x[1:2] .* 10    # identical output (less performant)
println(x)
 



x       = [3, 4, 5]

x[1:2]  = x[1:2] .* 10
println(x)
 



####################################################
#	scalar on the RHS
####################################################
 
x          = [-2, -1, 1]

x[x .< 0] .= 0
println(x)
 



####################################################
#	object itself on the RHS
####################################################
 
# assignment
 
x    = [1, 2, 3]

x    = x .* 10
println(x)
 



# mutations
 
x    = [1, 2, 3]

x   .= x .* 10
println(x)
 



x    = [1, 2, 3]

x[:] = x .* 10
println(x)
 



# distinguishing assignments and mutations
 
x    = [1, 2, 3]

x   .= x .* 10
println(x)
 



x    = [1, 2, 3]

@. x = x  * 10
println(x)
 



x    = [1, 2, 3]

x    = @. x * 10
println(x)
 



####################################################
#	view aliases on the LHS
####################################################
 
# example 1
 
x          = [-2, -1, 1]


x[x .< 0] .= 0
println(x)
 



x      = [-2, -1, 1]

slice  = view(x, x .< 0)     # or slice = @view x[x .< 0]
slice .= 0
println(x)
 



x      = [-2, -1, 1]

slice  = view(x, x .< 0)     # or slice = @view x[x .< 0]
slice  = 0                   # this does NOT modify `x`
println(x)
 



# example 2
 
x      = [1, 2, 3]

slice  = view(x, x .≥ 2)
slice .= slice .* 10        # same as 'x[x .≥ 2] = x[x .≥ 2] .* 10'
println(x)
 



x      = [1, 2, 3]

slice  = view(x, x .≥ 2)
slice  = slice .* 10        # this does NOT modify `x`
println(x)
 
x      = [1, 2, 3]

slice  = x[x .≥ 2]          # 'slice' is a copy
slice  = slice .* 10        # this does NOT modify `x`
println(x)
 
####################################################
#	WARNING ABOUT THE USE OF .= AND VIEW
####################################################
 
# correct way to mutate
 
x      = [-2, -1, 1]

slice  = view(x, x .< 0)
slice .= 0
println(x)
 



# incorrect ways -> no mutation
 
x      = [-2, -1, 1]

slice  = x[x .< 0]          # 'slice' is a copy
slice .= 0                  # this does NOT modify `x`
println(x)
 



x      = [-2, -1, 1]

slice  = view(x, x .< 0)
slice  = 0                  # this does NOT modify `x`
println(x)
 
