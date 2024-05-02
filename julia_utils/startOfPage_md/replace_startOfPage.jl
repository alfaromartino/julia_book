###################
#       BASICS
###################
# root folders
include(joinpath(homedir(), "JULIA_UTILS", "initial_folders.jl"))

# it loads multiple auxiliar utils
location_basics = joinpath(folderBook.julia_utils, "for_coding", "auxiliars")
                  include(joinpath(location_basics, "aux_include_at_top.jl"))


#names of PAGES in Franklin 
include(joinpath(location_basics, "aux_identify_folders.jl"))
pages_names = identify_folder_names(folderBook.index)





############################################################################
#
#                       FOLDERS
#
############################################################################

# file with julia code
_src_file(page_name) = joinpath(folderBook.pages, "$(page_name).md")
_src_text() = joinpath(@__DIR__, "start_of_pages.md")       # the text to be used for replacing has to be in the same folder as this file
    

####################################################
#	CHANGE  TEXT
####################################################


function regex_content_at_start(filejl)   
    
    #specify regex to capture code
    start_line  = raw"^ *\s*(\+\+\+.*"
    middle      = raw"[\s\S]*?"
    end_line    = raw"\s*\+\+\+.*)"

    pattern  = Regex("$(start_line)$(middle)$(end_line)")
    
    # read_file = open(filejl, "r")
    # content   = read(read_file, String)
    # close(read_file)

    #capture code
    #code_matched  = match(pattern, content)
    #code_content  = code_matched.captures

    #return code_content
end

function new_text_at_start()
    new_text = _src_text()
    
    read_file = open(new_text, "r")
    content   = read(read_file, String)
    close(read_file)    

    return content
end


function replace_startMDpage(filejl)    
    new_text = new_text_at_start()

    if isfile(filejl) 
        pattern = regex_content_at_start(filejl)
        replace_text!(splitdir(filejl)..., pattern, new_text)        
    end
end


# TO TRY ONE PAGE
#     filejl = _src_file(pages_names[1])     
#     replace_startMDpage(_src_file(pages_names[1]))

replace_startMDpage.(_src_file.(pages_names))
