
+++
section_name = "Some Title"
hascode      = true
hasmath      = true

# DO NOT DELETE
sections   = Pair{String,String}[]
dftoc      = globvar(:dftoc)
local_page = locvar(:fd_rpath)

[include(joinpath(@__DIR__, "julia_utils", "basics", file)) for file in readdir(joinpath("julia_utils", "basics"))]
(section_number, section_letter, section_title)  = create_sectionTitle(dftoc, local_page, section_name)
section_letter = section_letter         #Franklin doesn't recognize tuple assignation as locvars
section_number = section_number         #Franklin doesn't recognize tuple assignation as locvars

title     = section_title
prev_page = get_prevpage(dftoc, local_page)
next_page = get_nextpage(dftoc, local_page)

julia_version     = VERSION

path_codeDownload = getPath_codeDownload(dftoc, local_page)
pathPics          = getPath_pics(dftoc, local_page)
pathTikz          = getPath_tikz(dftoc, local_page)
+++
