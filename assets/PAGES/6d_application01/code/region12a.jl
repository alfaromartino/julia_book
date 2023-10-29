new_views = views_per_video      # it creates an alias, it's a view of the original object!!!

# 'temp' modifies 'views_per_video' -> you lose the original info
temp  = @view new_views[new_views .≥ viral_threshold]
temp .= temp .* 1.2