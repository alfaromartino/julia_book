include(joinpath(homedir(), "JULIA_foldersPaths", "initial_folders.jl"))
include(joinpath(folderBook.julia_utils, "for_coding", "for_codeDownload", "region0_benchmark.jl"))
 
############################################################################
#
#			        SECTION: "STRINGS"
#
############################################################################
 
############################################################################
#
#	CHARACTERS
#
############################################################################
 
# x equals the character 'a'
x = 'a'

# 'Char' allows for Unicode characters
x = 'β'
y = '🐒'
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
# any character is allowed to define a variable
🐒 = 2      # 🐒 represents a variable, just like if we had defined x = 2

y  = 🐒     # y equals 2, 🐒's value at that moment (not 🐒 itself)
z  = '🐒'   # z equals the character 🐒 (entirely independent of the 🐒 variable )
 
############################################################################
#
#	STRINGS
#
############################################################################
 
x = "Hello, beautiful world"

x = """Hello, beautiful world"""
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
############################################################################
#
#   STRING INTERPOLATION
#
############################################################################
 
number_students = 10


output_text     = "There are $(number_students) students in the course"
 
print_asis(output_text)       #hide
 
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
# <space_to_be_deleted>
 
number_matches  = 50
goals_per_match = 2

output_text     = "Last year, Messi scored $(number_matches * goals_per_match) goals"
 
print_asis(output_text)       #hide
 
