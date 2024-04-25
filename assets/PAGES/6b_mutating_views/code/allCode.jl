include(joinpath("/", "JULIA_UTILS", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
# necessary packages for this file
# using StatsBase, Random
 
############################################################################
#
#           MUTATION THROUGH VECTORS
#
############################################################################
 
x         = [1, 2, 3, 4]

x[3]      = 30
x[4]      = 40
print_asis(x) #hide
 
x         = [1, 2, 3, 4]


x[3:end]  = [30, 40]
print_asis(x) #hide
 
x         = [1, 2, 3, 4]


x[3:end]  = [x[i] * 10 for i in 3:length(x)]
print_asis(x) #hide
 
x         = [1, 2, 3, 4]


x[x .≥ 3] = [x[i] * 10 for i in 3:length(x)]
print_asis(x) #hide
 
x         = [1, 2, 3, 4]


x[x .≥ 3] = x[x .≥ 3] .* 10
print_asis(x) #hide
 
x    = [1, 2, 3, 4]

x    = x .* 10
print_asis(x) #hide
 
x    = [1, 2, 3, 4]

x[:] = x .* 10
print_asis(x) #hide
 
############################################################################
#
#           MUTATION THROUGH .=
#
############################################################################
 
x          = [-1, -2, 3, 4]

x[x .< 0] .= zeros(length(x[x .< 0]))       # same as 'x[x .< 0]  = zeros(length(x[x .< 0]))'
print_asis(x) #hide
 
x          = [-1, -2, 3, 4]

x[x .< 0] .= 0
print_asis(x) #hide
 
x      = [-1, -2, 3, 4]
slice  = view(x, x .< 0)

slice .= 0
print_asis(x) #hide
 
###############
# an explicit view
###############
 
x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= x[x .≥ 3] .* 10                 # same operation as 'x[x .≥ 3] = x[x .≥ 3] .* 10'
print_asis(x) #hide
 
x      = [1, 2, 3, 4]
slice  = view(x, x .≥ 3)

slice .= [i * 10 for i in [3,4]]     # same operation as 'x[x .≥ 3] = [i * 10 for i in [3,4]]'
print_asis(x) #hide
 
x          = [1, 2, 3, 4]
x[x .≥ 3] .= x[x .≥ 3] .* 10
print_asis(x) #hide
 
x          = [1, 2, 3, 4]
x[x .≥ 3]  = x[x .≥ 3] .* 10
print_asis(x) #hide
 
x          = [-1, -2, 1, 2]

x[x .< 0] .= 0
print_asis(x) #hide
 
############################################################################
#
# SORTPERM -> indices of the sorted vector
#
############################################################################
 
x  = [-1, -2, 1, 2]

y  = view(x, x .< 0)
y .= 0
 
print_asis(y) #hide
 
print_asis(x) #hide
 
x  = [-1, -2, 1, 2]

y  = x[x .< 0]              # `y` is a new object
y .= 0                      # this does NOT modify `x`
 
print_asis(y) #hide
 
print_asis(x) #hide
 
x  = [1, 2, 3, 4]

y  = view(x, x .≥ 3)
y .= x[x .≥ 3] .* 10
print_asis(x) #hide
 
x  = [1, 2, 3, 4]

y  = view(x, x .≥ 3)
y  = x[x .≥ 3] .* 10    # this creates a new variable 'y'
print_asis(x) #hide
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements


for i in eachindex(x)
    x[i] = i
end
 
y = [3, 4, 5]
x = similar(y)            # `x` mimicks the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = i
end
 
x = zeros(Int64,3)         # `x` is Vector{Int64} with 3 elements equal to zero


for i in eachindex(x)
    x[i] = i
end
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined Int64 elements


for i in eachindex(x)
#    x[i] = i * 2.5                
end
 
y = [3, 4, 5]
x = similar(y)            # `x` has the same type as `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
#    x[i] = i * 2.5
end
 
x = zeros(Int64,3)         # `x` is Vector{Int64} with 3 elements equal to zero


for i in eachindex(x)
#    x[i] = i * 2.5 
end
 
