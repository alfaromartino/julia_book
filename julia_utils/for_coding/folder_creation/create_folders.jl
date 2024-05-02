###################
#       BASICS
###################
# it loads multiple auxiliar utils
location_basics = joinpath(folderBook.julia_utils, "for_coding", "auxiliars")
                  include(joinpath(location_basics, "aux_include_at_top.jl"))

#names of PAGES in Franklin 
include(joinpath(location_basics, "aux_identify_folders.jl"))



###################
#       CREATE FOLDERS (if they don't already exist)
###################

function create_folder(x) 
    isdir(x) || (mkdir(x))
    x
end


function create_assets_folders(folder_asset, page_folder)
    asset_folder    = create_folder(joinpath(folder_asset, page_folder))
    code_folder     = create_folder(joinpath(asset_folder, "code"))
    pics_folder     = create_folder(joinpath(asset_folder, "pics"))
    download_folder = create_folder(joinpath(asset_folder, "codeDownload"))
end


page_folders = identify_folder_names(folderBook.index)
create_assets_folders.(folderBook.assets, page_folders)


