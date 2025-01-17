#version 450

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;         
    mat4 view;          
    mat4 proj;          
    mat4 bulletModel;   
    int isBullet;       // Flag: 0 for weapon, 1 for bullet
};

layout(location = 0) in vec3 inPosition;   
layout(location = 1) in vec3 inColor;      
layout(location = 2) in vec2 inTexCoord;   

layout(location = 0) out vec3 fragColor;   
layout(location = 1) out vec2 fragTexCoord; 

void main() {
    // Choose transformation matrix based on the isBullet flag
    mat4 transform = (isBullet == 1) ? bulletModel : model;

    // Apply transformations
    gl_Position = proj * view * transform * vec4(inPosition, 1.0);
    fragColor = inColor;
    fragTexCoord = inTexCoord;
}