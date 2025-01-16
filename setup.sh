#!/bin/bash

mkdir -p external
cd external

echo "Cloning GLFW..."
git clone https://github.com/glfw/glfw.git
cd glfw
git checkout 3.3.8
cd ..

echo "Cloning GLM..."
git clone https://github.com/g-truc/glm.git
cd glm
git checkout 0.9.9.8
cd ..

echo "Cloning tinyobjloader..."
git clone https://github.com/tinyobjloader/tinyobjloader.git
cd tinyobjloader
git checkout release
cd ..

echo "Cloning STB..."
git clone https://github.com/nothings/stb.git

cd ..
echo "Setup complete!" 