###################
#       BASICS
###################
include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))

include(joinpath(folder_googleDrive, "JULIA", "main", "initial_folders.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "user_IO_utils_v01.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "for_websites","code_split_gather_v01.jl"))

include(joinpath(folderBook.julia_utils, "for_coding", "aux_identify_folders.jl"))


###################
#       CREATE FOLDERS (if they don't already exist)
###################

function create_folder(x) 
    isdir(x) || (mkdir(x))
    x
end


function create_assets_folders(folder_asset, page_folder)
    asset_folder    = create_folder("$(folderBook.assets)\\$(page_folder)")
    code_folder     = create_folder("$(asset_folder)\\code")
    pics_folder     = create_folder("$(asset_folder)\\pics")
    download_folder = create_folder("$(asset_folder)\\codeDownload")
end


page_folders = identify_folder_names(folderBook.index)
create_assets_folders.(folderBook.assets, page_folders)