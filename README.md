# TracerRounds_Project
```markdown:README.md
# TracerRounds Project

A Vulkan-based graphics application with GLFW, GLM, ImGui and other dependencies.

## Prerequisites

### Windows
- Visual Studio 2019/2022 with C++ workload
- [Vulkan SDK](https://vulkan.lunarg.com/sdk/home#windows) 
- CMake 3.20+
- Git

### Linux
- GCC/Clang compiler
- [Vulkan SDK](https://vulkan.lunarg.com/sdk/home#linux)
- CMake 3.20+
- Git
- Build essentials:
```bash
sudo apt install build-essential xorg-dev
```

## Setup Instructions

### Windows

1. Install Vulkan SDK from LunarG website
2. Clone the repository:
```bash
git clone https://github.com/yourusername/TracerRounds_Project.git
cd TracerRounds_Project
```

3. Update Vulkan SDK path in `.env.cmake` if needed:
```cmake
set(VULKAN_SDK_PATH "C:/VulkanSDK/1.3.250.1") # Change to your SDK version
```

4. Run setup script to get dependencies:
```bash
setup.bat
```

5. Configure and build:
```bash
mkdir build
cd build
cmake ..
cmake --build . --config Release
```

6. Run the application:
```bash
.\Release\TracerRounds.exe
```

### Linux 

1. Install Vulkan SDK:
```bash
wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo tee /etc/apt/trusted.gpg.d/lunarg.asc
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-jammy.list http://packages.lunarg.com/vulkan/lunarg-vulkan-jammy.list
sudo apt update
sudo apt install vulkan-sdk
```

2. Clone the repository:
```bash
git clone https://github.com/yourusername/TracerRounds_Project.git
cd TracerRounds_Project
```

3. Make setup script executable and run:
```bash
chmod +x setup.sh
./setup.sh
```

4. Configure and build:
```bash
mkdir build && cd build
cmake ..
make -j$(nproc)
```

5. Run the application:
```bash
./TracerRounds
```

## Project Structure

```
TracerRounds_Project/
├── external/           # Third-party libraries
│   ├── GLFW/
│   ├── GLM/
│   ├── imgui/
│   ├── stb-master/
│   └── tinyobjloader-release/
├── shaders/           # Vulkan shaders
│   ├── shader.vert
│   └── shader.frag
├── src/              # Source files
├── .env.cmake        # Environment configuration
├── CMakeLists.txt    # Build configuration
├── setup.bat         # Windows setup script
└── setup.sh          # Linux setup script
```

## Shader Compilation

Compile shaders using:
```bash
# Windows
%VULKAN_SDK%/Bin/glslc.exe shaders/shader.vert -o shaders/vert.spv
%VULKAN_SDK%/Bin/glslc.exe shaders/shader.frag -o shaders/frag.spv

# Linux
glslc shaders/shader.vert -o shaders/vert.spv
glslc shaders/shader.frag -o shaders/frag.spv
```

## Troubleshooting

- If CMake can't find Vulkan SDK:
  - Verify VULKAN_SDK_PATH in .env.cmake
  - Check if Vulkan SDK is properly installed
  - On Linux, ensure vulkan-sdk package is installed

- If build fails:
  - Make sure all dependencies are properly cloned (run setup script again)
  - Check compiler/CMake version requirements
  - Verify shader compilation

- If application crashes:
  - Check if shaders are compiled and in correct location
  - Verify Vulkan validation layers are enabled in debug builds
  - Look for validation layer messages in console output
```

This README provides comprehensive setup instructions for both Windows and Linux, along with project structure, shader compilation instructions, and troubleshooting tips. Users should be able to get the project running by following these steps.
