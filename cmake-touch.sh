#!/usr/bin/env bash

# touch project.config.h.in
echo -e "#define $1_MAJOR_VERSION @$1_MAJOR_VERSION@\n"\
"#define $1_MINOR_VERSION @$1_MINOR_VERSION@\n" > $1_config.h.in

# touch main.cpp
echo -e "#include <stdio.h>\n"\
"#include <$1_config.h>\n"\
"\n"\
"int main( int argc, char * argv[] )\n"\
"{\n"\
"   printf( \"hello world\\\n\" );\n"\
"   return 0;\n"\
"}\n" > main.cpp

# touch CMakeLists.txt from template
cp ~/.CMakeLists.txt.tpl ./CMakeLists.txt

# replace the PROJECT_NAME to $1
sed -i -e "s/\${CMAKE_PROJECT_NAME}/$1/g" ./CMakeLists.txt 
