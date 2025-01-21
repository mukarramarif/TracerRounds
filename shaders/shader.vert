#version 450

layout(binding = 0) uniform UniformBufferObject {
    mat4 model;
    mat4 view;
    mat4 proj;
} ubo;

struct Bullet {
    mat4 matrix;
};

layout(std140, binding = 2) buffer BulletSSBO {
    Bullet bullets[];
};

layout(push_constant) uniform PushConsts {
    int bulletIndex;  // -1 for weapon, >= 0 for bullets
} pushConsts;

layout(location = 0) in vec3 inPosition;
layout(location = 1) in vec3 inColor;
layout(location = 2) in vec2 inTexCoord;

layout(location = 0) out vec3 fragColor;
layout(location = 1) out vec2 fragTexCoord;

void main() {
    if (pushConsts.bulletIndex >= 0) {
        gl_Position = ubo.proj * ubo.view * bullets[pushConsts.bulletIndex].matrix * vec4(inPosition, 1.0);
    } else {
        gl_Position = ubo.proj * ubo.view * ubo.model * vec4(inPosition, 1.0);
    }
    
    fragColor = inColor;
    fragTexCoord = inTexCoord;
}