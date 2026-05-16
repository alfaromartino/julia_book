using StatsBase

function to_sort_x(x)
    dict_count = countmap(x)
    sorted_x   = sort(x, by = (x -> dict_count[x]))
    return sorted_x
end

x        = [0, 4, 4, 4, 5, 5]
sorted_x = to_sort_x(x)