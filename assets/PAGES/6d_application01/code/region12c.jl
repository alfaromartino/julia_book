new_views = copy(views_per_video)


temp  = @view new_views[new_views .≥ viral_threshold]
temp .= temp .* 1.2