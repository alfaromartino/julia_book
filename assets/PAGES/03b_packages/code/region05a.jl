x   = [1,2] #hide 
y   = [1,2] #hide 
z   = Vector{Float64}(undef,2) #hide 
foo = log   #hide 

# both are equivalent
   z .= foo.(x .+ y)
@. z  = foo(x  + y)          # @. adds . to =, foo, and +