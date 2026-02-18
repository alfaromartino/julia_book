include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
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
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 2, 3]

x[x .≥ 2] = [2, 3] .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# updating
 
x         = [1, 2, 3]

x[2:end]  = [x[i] * 10 for i in 2:length(x)]
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 2, 3]

x[x .≥ 2] = x[x .≥ 2] .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# single-element slice
 
x         = [1, 2, 3]

x[3]      = 30
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	WARNING: vectors can only be mutated by objects of the same type
####################################################
 
x         = [1, 2, 3]    # Vector{Int64}

# x[2:3]    = [3.5, 4]     #ERROR # 3.5 is Float64
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x         = [1, 2, 3]    # Vector{Int64}

x[2:3]    = [3.0, 4]     # 3.0 is Float64 but accepts conversion
print_asis(x)   #hide
 
############################################################################
#
#   MUTATION VIA FOR-LOOPS
#
############################################################################
 
x = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements


for i in eachindex(x)
    x[i] = 0
end
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
y = [1, 2, 3]
x = similar(y)               # `x` replicates the type of `y`, which is Vector{Int64}(undef, 3)

for i in eachindex(x)
    x[i] = 0
end
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x     = zeros(3)
slice = view(x, 2:3)

for i in eachindex(slice)
    slice[i] = 1
end
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# via for-loop
 
x     = zeros(3)


for i in 2:3
    x[i] = 1
end
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements

for i in eachindex(x)
    x[i] = 0
end
print_asis(x) #hide
 
x    = Vector{Int64}(undef, 3)  # `x` is initialized with 3 undefined elements

x[1] = 0
x[2] = 0
x[3] = 0
print_asis(x) #hide
 
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
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x       = [3, 4, 5]

x[1:2]  = x[1:2] .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	scalar on the RHS
####################################################
 
x          = [-2, -1, 1]

x[x .< 0] .= 0
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	object itself on the RHS
####################################################
 
# assignment
 
x    = [1, 2, 3]

x    = x .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# mutations
 
x    = [1, 2, 3]

x   .= x .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [1, 2, 3]

x[:] = x .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# distinguishing assignments and mutations
 
x    = [1, 2, 3]

x   .= x .* 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [1, 2, 3]

@. x = x  * 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x    = [1, 2, 3]

x    = @. x * 10
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
####################################################
#	view aliases on the LHS
####################################################
 
# example 1
 
x          = [-2, -1, 1]


x[x .< 0] .= 0
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [-2, -1, 1]

slice  = view(x, x .< 0)     # or slice = @view x[x .< 0]
slice .= 0
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [-2, -1, 1]

slice  = view(x, x .< 0)     # or slice = @view x[x .< 0]
slice  = 0                   # this does NOT modify `x`
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# example 2
 
x      = [1, 2, 3]

slice  = view(x, x .≥ 2)
slice .= slice .* 10        # same as 'x[x .≥ 2] = x[x .≥ 2] .* 10'
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [1, 2, 3]

slice  = view(x, x .≥ 2)
slice  = slice .* 10        # this does NOT modify `x`
print_asis(x) #hide
 
x      = [1, 2, 3]

slice  = x[x .≥ 2]          # 'slice' is a copy
slice  = slice .* 10        # this does NOT modify `x`
print_asis(x) #hide
 
####################################################
#	WARNING ABOUT THE USE OF .= AND VIEW
####################################################
 
# correct way to mutate
 
x      = [-2, -1, 1]

slice  = view(x, x .< 0)
slice .= 0
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# incorrect ways -> no mutation
 
x      = [-2, -1, 1]

slice  = x[x .< 0]          # 'slice' is a copy
slice .= 0                  # this does NOT modify `x`
print_asis(x) #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
x      = [-2, -1, 1]

slice  = view(x, x .< 0)
slice  = 0                  # this does NOT modify `x`
print_asis(x) #hide
 
