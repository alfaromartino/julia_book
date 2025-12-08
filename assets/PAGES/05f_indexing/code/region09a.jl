x            = [-100, 2, 4, 100]
list         = [minimum(x), maximum(x)]

#logical indexing
bool_indices = in(list).(x)   #no need to use `Ref(list)`
y            = x[bool_indices]