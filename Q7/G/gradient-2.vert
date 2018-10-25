#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMax;
uniform vec3 boundingBoxMin;

vec4 RED = vec4(1,0,0,1);
vec4 YELLOW = vec4(1,1,0,1);
vec4 GREEN = vec4(0,1,0,1);
vec4 CIAN = vec4(0,1,1,1);
vec4 BLUE = vec4(0,0,1,1);
void main()
{
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
    float pos = 2*(gl_Position.y/gl_Position.w + 1.0);
    if(pos == 0) frontColor = RED;
    else if (pos == 4) frontColor = BLUE;
    else if(pos < 1) frontColor = mix(RED, YELLOW, fract(pos));
    else if(pos < 2) frontColor = mix(YELLOW, GREEN, fract(pos));
    else if(pos < 3) frontColor = mix(GREEN, CIAN, fract(pos));
    else if(pos < 4) frontColor = mix(CIAN, BLUE, fract(pos));

}
