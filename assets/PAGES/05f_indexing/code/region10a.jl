x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

#identical vectors for logical indexing
bool_indices = (!in).(x, Ref(list))
bool_indices = (∉).(x, Ref(list))          #or `(!∈).(x, Ref(list))`
y            = x[bool_indices]