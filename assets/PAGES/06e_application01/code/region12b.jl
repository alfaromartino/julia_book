new_viewers = copy(viewers)

# wrong -> not using `temp .= temp .* 1.2`
temp  = @view new_viewers[new_viewers .≥ viral_threshold]
temp  = temp .* 1.2     # it creates a new variable 'temp', it does not modify 'new_viewers'