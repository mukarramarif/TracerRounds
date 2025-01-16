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
)

# Include directories
target_include_directories(${PROJECT_NAME} 
    PRIVATE ${Vulkan_INCLUDE_DIRS}
    PRIVATE ${STB_PATH}
)

# Copy shader files if you have any
# add_custom_command(
#     TARGET ${PROJECT_NAME} POST_BUILD
#     COMMAND ${CMAKE_COMMAND} -E copy_directory
#     ${CMAKE_SOURCE_DIR}/shaders
#     ${CMAKE_BINARY_DIR}/shaders
# )