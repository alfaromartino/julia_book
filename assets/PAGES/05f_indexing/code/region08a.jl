x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

# logical indexing
bool_indices = x .∈ Ref(list)            # ∈ is the only option, not possible to broadcast `in`


y            = x[bool_indices]