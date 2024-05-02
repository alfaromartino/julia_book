###################
#       BASICS
###################
# root folders
include(joinpath(homedir(),"JULIA_UTILS", "initial_folders.jl"))

# it loads multiple auxiliar utils
location_basics = joinpath(folderBook.julia_utils, "for_coding", "auxiliars")
                  include(joinpath(location_basics, "aux_include_at_top.jl"))


###################
#       identify folders' names
###################

# pages_folder = identify_folder_names(folderBook.index)
function identify_folder_names(path_index)
    folder_pages = joinpath(path_index, "PAGES")
    list         = readdir(folder_pages)
    page_folders = [file for file in list if isfile(joinpath(folder_pages, file))] |>
                    x -> replace.(x, r".md$" => "")

    page_folders
end