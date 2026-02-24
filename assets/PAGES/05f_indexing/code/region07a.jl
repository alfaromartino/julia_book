x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

# logical indexing (both versions are equivalent)
bool_indices = in.(x, Ref(list))    #`Ref(list)` or `(list,)`
bool_indices = (∈).(x,Ref(list))

y            = x[bool_indices]