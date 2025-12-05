############################################################################
#   AUXILIARS FOR BENCHMARKING
############################################################################
#= The following package defines the macro `@ctime`
    Same output as `@btime` from BenchmarkTools, but using Chairmarks (which is way faster) 
    For accurate results, interpolate each function argument using `$`. E.g., `@ctime foo($x)` for timing `foo(x)`=#

# import Pkg; Pkg.add(url="https://github.com/alfaromartino/FastBenchmark.git") #uncomment if you don't have the package installed
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
 
############################################################################
#
#           MUTATIONS VIA VECTORS
#
############################################################################
 
x         = [1, 2, 3]

x[3]      = 30
x
 



x         = [1, 2, 3]

x[2:end]  = [20, 30]
x
 



x         = [1, 2, 3]

x[x .≥ 2] = [2, 3] .* 10
x
 



x         = [1, 2, 3]

x[x .≥ 2] = x[x .≥ 2] .* 10
x
 



x         = [1, 2, 3]

x[2:end]  = [x[i] * 10 for i in 2:length(x)]
x
 



############################################################################
#
#           MUTATION VIA FOR-LOOPS
#
############################################################################
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements


for i in eachindex(x)
    x[i] = 0
end
x
 



y = [1, 2, 3]
x = similar(y)               # `x` replicates the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = 0
end
x
 



x     = zeros(3)
slice = view(x, 2:3)

for i in eachindex(slice)
    slice[i] = 1
end
x
 



x     = zeros(3)


for i in 2:3
    x[i] = 1
end
x
 



x    = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements

for i in eachindex(x)
    x[i] = 0
end
x
 
x    = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements

x[1] = 0
x[2] = 0
x[3] = 0
x
 
############################################################################
#
#           MUTATION VIA .=
#
############################################################################
 
####################################################
#	use directly `=` for vectors on the RHS
####################################################
 
x       = [3, 4, 5]

x[1:2] .= x[1:2] .* 10    # identical output (less performant)
x
 



x       = [3, 4, 5]

x[1:2]  = x[1:2] .* 10
x
 



####################################################
#	scalar replacement
####################################################
 
x          = [-2, -1, 1]

x[x .< 0] .= 0
x
 



####################################################
#	WARNING: MUTATION VS ASSIGNMENT
####################################################
 
# assignment
 
x    = [1, 2, 3]

x    = x .* 10
x
 



# mutation
 
x    = [1, 2, 3]

x[:] = x .* 10
x
 



x    = [1, 2, 3]

x   .= x .* 10
x
 



x    = [1, 2, 3]

@. x = x  * 10
x
 



x    = [1, 2, 3]

x    = @. x * 10
x
 



############################################################################
#
#           COMBINING .= and view
#
############################################################################
 
x          = [-2, -1, 1]


x[x .< 0] .= 0
x
 



x      = [-2, -1, 1]

slice  = view(x, x .< 0)     # or slice = @view x[x .< 0]
slice .= 0
x
 



x      = [-2, -1, 1]

slice  = view(x, x .< 0)     # or slice = @view x[x .< 0]
slice  = 0                   # this does NOT modify `x`
x
 



x      = [1, 2, 3]

slice  = view(x, x .≥ 2)
slice .= slice .* 10        # same as 'x[x .≥ 2] = x[x .≥ 2] .* 10'
x
 



x      = [1, 2, 3]

slice  = view(x, x .≥ 2)
slice  = slice .* 10        # this does NOT modify `x`
x
 
x      = [1, 2, 3]

slice  = x[x .≥ 2]          # 'slice' is a copy
slice  = slice .* 10        # this does NOT modify `x`
x
 
####################################################
#	WARNING ABOUT THE USE OF .= AND VIEW
####################################################
 
# correct way to mutate
 
x      = [-2, -1, 1]

slice  = view(x, x .< 0)
slice .= 0
x
 



# incorrect ways -> no mutation
 
x      = [-2, -1, 1]

slice  = x[x .< 0]          # 'slice' is a copy
slice .= 0                  # this does NOT modify `x`
x
 



x      = [-2, -1, 1]

slice  = view(x, x .< 0)
slice  = 0                  # this does NOT modify `x`
x
 
