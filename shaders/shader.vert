#version 450

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;         
    mat4 view;          
    mat4 proj;          
    int numBullets;
} ubo;

layout(location = 0) in vec3 inPosition;   
layout(location = 1) in vec3 inColor;      
layout(location = 2) in vec2 inTexCoord;   

struct Bullet {
    mat4 matrix;
};

layout(std430, binding = 2) buffer BulletSSBO {
    Bullet bullets[];
};

layout(push_constant) uniform PushConsts {
    int bulletIndex;  // -1 for weapon, >= 0 for bullets
} pushConsts;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec2 fragTexCoord;

void main() {
    // Get the instance index
    int instanceIndex = gl_InstanceIndex;
    
    // Default to model matrix
    mat4 modelMatrix = ubo.model;
    
    // Only use bullet matrix if this is a valid bullet instance
    if (instanceIndex < ubo.numBullets && instanceIndex >= 0) {
        modelMatrix = bullets[pushConsts.bulletIndex].matrix;
        
    }
    
    // Calculate final position
    vec4 worldPos = modelMatrix * vec4(inPosition, 1.0);
    vec4 viewPos = ubo.view * worldPos;
    gl_Position = ubo.proj * viewPos;
    
    // Pass through other attributes
    fragColor = inColor;
    fragTexCoord = inTexCoord;
}