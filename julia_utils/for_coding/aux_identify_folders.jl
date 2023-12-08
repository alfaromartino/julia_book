###################
#       BASICS
###################
include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))

include(joinpath(folder_googleDrive, "JULIA", "main", "initial_folders.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "user_IO_utils_v01.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "for_websites","code_split_gather_v01.jl"))


###################
#       identify folders' names
###################

# pages_folder = identify_folder_names(folderBook.index)
function identify_folder_names(path_index)
    folder_pages = joinpath(path_index, "PAGES")
    list         = readdir(folder_pages)
    page_folders = [file for file in list if isfile(joinpath(folder_pages, file))]
    page_folders = replace.(page_folders, r".md$" => "")

    page_folders
end
