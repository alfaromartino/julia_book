
###################
#       BASICS
###################
include(joinpath("C:/", "JULIA_UTILS", "initial_folders.jl"))

include(joinpath(folder_googleDrive, "JULIA", "main", "initial_folders.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "user_IO_utils_v01.jl"))
include(joinpath(folder_googleDrive, "JULIA", "main", "for_websites","code_split_gather_v01.jl"))


#names of PAGES in Franklin 
include(joinpath(folderBook.julia_utils, "for_coding", "aux_identify_folders.jl"))
pages_folder = identify_folder_names(folderBook.index)


###################
#       execute_and_store outputs
###################

# file with julia code
function src_file(page_folder)
    src_folder = folderBook.calculations
    name_file  = "01_calculations_used.jl"

    src_file = joinpath(src_folder, page_folder, name_file)
end

# folder to store the code
function dst_path(page_folder)
    asset_folder = folderBook.assets
    dst_folder   = "code"    
        
    dst_path = joinpath(asset_folder, page_folder, dst_folder)
end


function execute_and_store(page_folder)
    code_file  = src_file(page_folder)
    dst_folder = dst_path(page_folder)

    if isfile(code_file)
        code_names = splitAndGatherCode(dst_folder, code_file)[1]        
        store_outputs(dst_folder, code_names)
    end
end

#=
 for page_folder in pages_folder
     execute_and_store(page_folder, asset_folder, src_folder, name_file, dst_folder)
 end
=#


###################
#     CODE FOR CODEDOWNLOAD
###################

# file with julia code
function src_file(page_folder)
    src_folder = folderBook.calculations
    name_file  = "00_calculations_toprint.jl"

    src_file = joinpath(src_folder, page_folder, name_file)
end

# folder to store the code
function dst_path(page_folder)
    asset_folder = folderBook.assets
    dst_folder   = "codeDownload"    
        
    dst_path = joinpath(asset_folder, page_folder, dst_folder)
end

function code_for_download(page_folder)
    code_file  = src_file(page_folder)
    dst_folder = dst_path(page_folder)

    if isfile(code_file)
        onlyGatherCode(dst_folder, code_file; name_file="allCode")
    end
end

code_for_download.(pages_folder)
