# Vulkan SDK Path - Change this to your system's Vulkan SDK path
if (WIN32)
    set(VULKAN_SDK_PATH "C:/VulkanSDK/1.3.250.1")
elseif (UNIX)
    set(VULKAN_SDK_PATH "/usr/local/")
endif()

# External library paths
set(EXTERNAL_DIR "${CMAKE_SOURCE_DIR}/external")
set(GLFW_PATH "${EXTERNAL_DIR}/GLFW")
set(GLM_PATH "${EXTERNAL_DIR}/GLM")
set(TINYOBJ_PATH "${EXTERNAL_DIR}/tinyobjloader-release")
set(STB_PATH "${EXTERNAL_DIR}/stb-master")
