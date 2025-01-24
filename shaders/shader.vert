#version 450

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;         
    mat4 view;          
    mat4 proj;          

}ubo;
layout(binding = 1) buffer BulletBuffer {
       Bullet bullets[];
};
layout(location = 0) in vec3 inPosition;   
layout(location = 1) in vec3 inColor;      
layout(location = 2) in vec2 inTexCoord;   

layout(location = 0) out vec3 fragColor;   
layout(location = 1) out vec2 fragTexCoord; 

void main() {
    // Choose transformation matrix based on the isBullet flag
    int instanceIndex = gl_InstanceIndex;


    // Apply transformations
    mat4 modelMatrix = (instanceIndex < ubo.numBullets) ? ubo.bulletModels[instanceIndex] : ubo.model;
    gl_Position = ubo.proj * ubo.view * modelMatrix * vec4(inPosition, 1.0);
    fragColor = inColor;
    fragTexCoord = inTexCoord;
}
