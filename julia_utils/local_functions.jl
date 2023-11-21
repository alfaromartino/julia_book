using DataFrames

# function to retrieve the path of assets and for codeDownload
get_pathassets(dftoc, local_page)       = string(first(dftoc[dftoc.pagemd.==local_page,:path_assets]))
get_pathcodeDownload(dftoc, local_page) = string(first(dftoc[dftoc.pagemd.==local_page,:path_codeDownload]))