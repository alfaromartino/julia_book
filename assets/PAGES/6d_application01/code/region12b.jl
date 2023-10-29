new_views = copy(views_per_video)

# wrong -> not using `temp .= temp .* 1.2`
temp  = @view new_views[new_views .≥ viral_threshold]
temp  = temp .* 1.2             # it creates a new variable 'temp', it does not modify 'new_views'