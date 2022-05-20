cmake_minimum_required(VERSION 3.17)
project(src C)

file(GLOB SOURCES
        hashtable.h						//*号对应具体的文件名
        hashtable.h
        )


set(CMAKE_C_STANDARD 99)

#add_executable(src main.c)
add_executable(src main.cpp ${SOURCE_FILES} ${SOURCES})
add_executable(src hashtable.h.c)