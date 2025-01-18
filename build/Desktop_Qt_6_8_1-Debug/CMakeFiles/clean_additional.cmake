# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/appDyno_Info_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/appDyno_Info_autogen.dir/ParseCache.txt"
  "appDyno_Info_autogen"
  )
endif()
