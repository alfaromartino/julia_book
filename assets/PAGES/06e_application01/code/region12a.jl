new_viewers = viewers     # it creates an alias, it's a view of the original object!!!

# 'temp' modifies 'viewers' -> you lose the original info
temp  = @view new_viewers[new_viewers .≥ viral_threshold]
temp .= temp .* 1.2