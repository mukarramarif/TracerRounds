cmake_minimum_required(VERSION 3.20)
project(TracerRounds VERSION 1.0)

# Include environment variables
include(.env.cmake)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Configure Vulkan
find_package(Vulkan REQUIRED)

# Configure GLFW
add_subdirectory(${GLFW_PATH})

# Configure GLM
add_subdirectory(${GLM_PATH})

# Configure tinyobjloader
add_subdirectory(${TINYOBJ_PATH})

# Configure imgui
add_subdirectory(${IMGUI_PATH})
target_include_directories(imgui
    PUBLIC ${GLFW_PATH}/include
    PUBLIC ${Vulkan_INCLUDE_DIRS}
)

# Add source files
add_executable(${PROJECT_NAME} 
    main.cpp
)

# Link libraries
target_link_libraries(${PROJECT_NAME} 
    PRIVATE Vulkan::Vulkan 
    PRIVATE glfw
    PRIVATE glm
    PRIVATE tinyobjloader
    PRIVATE imgui
)

# Include directories
target_include_directories(${PROJECT_NAME} 
    PRIVATE ${Vulkan_INCLUDE_DIRS}
    PRIVATE ${STB_PATH}
    PRIVATE ${IMGUI_PATH}
)

# Copy shader files if you have any
add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/shaders
    ${CMAKE_BINARY_DIR}/shaders
)

# Copy texture files to build directory
add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/textures
    ${CMAKE_BINARY_DIR}/textures
)

# Copy model files to build directory
add_custom_command(
    TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
    ${CMAKE_SOURCE_DIR}/models
    ${CMAKE_BINARY_DIR}/models
)

# Add shader compilation
find_program(GLSL_VALIDATOR glslangValidator HINTS 
  ${Vulkan_GLSLANG_VALIDATOR_EXECUTABLE} 
  /usr/bin 
  /usr/local/bin 
  ${VULKAN_SDK_PATH}/Bin
  ${VULKAN_SDK}/Bin
  $ENV{VULKAN_SDK}/Bin)

if (NOT GLSL_VALIDATOR)
    message(FATAL_ERROR "glslangValidator not found!")
endif()

# Compile shaders
set(SHADER_SOURCE_DIR ${CMAKE_SOURCE_DIR}/shaders)
set(SHADER_BINARY_DIR ${CMAKE_BINARY_DIR}/shaders)

file(MAKE_DIRECTORY ${SHADER_BINARY_DIR})

# Find only vertex and fragment shaders
file(GLOB SHADER_SOURCES 
    ${SHADER_SOURCE_DIR}/*.vert
    ${SHADER_SOURCE_DIR}/*.frag
)

# Generate output SPV files list
set(SHADER_SPV_FILES "")
foreach(SHADER ${SHADER_SOURCES})
    get_filename_component(FILENAME ${SHADER} NAME)
    get_filename_component(BASENAME ${FILENAME} NAME_WE)
    get_filename_component(EXTENSION ${FILENAME} EXT)
    string(SUBSTRING ${EXTENSION} 1 -1 EXTENSION)
    set(SPV_FILE ${EXTENSION}.spv)
    list(APPEND SHADER_SPV_FILES ${SPV_FILE})
    
    add_custom_command(
        OUTPUT ${SPV_FILE}
        COMMAND ${GLSL_VALIDATOR} -V ${SHADER} -o ${SPV_FILE}
        DEPENDS ${SHADER}
        COMMENT "Compiling shader ${FILENAME}"
    )
endforeach()

add_custom_target(shaders ALL DEPENDS ${SHADER_SPV_FILES})
add_dependencies(${PROJECT_NAME} shaders)