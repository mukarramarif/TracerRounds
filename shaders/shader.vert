#version 450

layout(binding = 0) uniform UniformBufferObject {
<<<<<<< HEAD
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
   


struct Bullet {
    mat4 matrix;
};

layout(std140, binding = 2) buffer BulletSSBO {
    Bullet bullets[];
};
>>>>>>> 54efe9059bdc24476c13956b061dd3479e879cee

layout(push_constant) uniform PushConsts {
    int bulletIndex;  // -1 for weapon, >= 0 for bullets
} pushConsts;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec2 inTexCoord;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec2 fragTexCoord;

void main() {
<<<<<<< HEAD
    // Choose transformation matrix based on the isBullet flag
    int instanceIndex = gl_InstanceIndex;
   

    // Apply transformations
    mat4 modelMatrix = (instanceIndex < ubo.numBullets) ? ubo.bulletModels[instanceIndex] : ubo.model;
    gl_Position = ubo.proj * ubo.view * modelMatrix * vec4(inPosition, 1.0);

    if (pushConsts.bulletIndex >= 0) {
        gl_Position = ubo.proj * ubo.view * bullets[pushConsts.bulletIndex].matrix * vec4(inPosition, 1.0);
    } else {
        gl_Position = ubo.proj * ubo.view * ubo.model * vec4(inPosition, 1.0);
    }
    
>>>>>>> 54efe9059bdc24476c13956b061dd3479e879cee
    fragColor = inColor;
    fragTexCoord = inTexCoord;
}
