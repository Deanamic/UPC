#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

vec4 NEGRE = vec4(0,0,0,0);
vec4 GRIS = vec4(0.8);

void main()
{
    vec3 N = normalize(normalMatrix * normal);
    frontColor = vec4(color,1.0);
    vtexCoord = texCoord;
    /*
    vtexCoord = vec3(
    	(vertex.x - boundingBoxMin.x)/(boundingBoxMax.x - boundingBoxMin.x),
    	(vertex.y - boundingBoxMin.y)/(boundingBoxMax.y - boundingBoxMin.y),
    	(vertex.z - boundingBoxMin.z)/(boundingBoxMax.z - boundingBoxMin.z));
    	*/
    gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
