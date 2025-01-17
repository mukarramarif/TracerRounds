@echo off
mkdir external
cd external

echo Cloning GLFW...
git clone https://github.com/glfw/glfw.git GLFW
cd GLFW
git checkout 3.3.8
cd ..

echo Cloning GLM...
git clone https://github.com/g-truc/glm.git GLM
cd GLM
git checkout 0.9.9.8
cd ..

echo Cloning tinyobjloader...
git clone https://github.com/tinyobjloader/tinyobjloader.git tinyobjloader-release
cd tinyobjloader-release
git checkout release
cd ..

echo Cloning STB...
git clone https://github.com/nothings/stb.git stb-master

echo Cloning ImGui...
git clone https://github.com/ocornut/imgui.git imgui

cd ..
echo Setup complete! 