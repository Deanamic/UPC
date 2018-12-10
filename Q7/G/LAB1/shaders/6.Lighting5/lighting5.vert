#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

out vec3 NW, VW, LW;
out vec3 NE, VE, LE;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform vec4 lightPosition;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewMatrixInverse;

void main()
{
  vec3 P = (modelViewMatrix*vec4(vertex.xyz, 1)).xyz;
  //WORLD SPACE
  NW = normal;
  VW = (modelViewMatrixInverse*vec4(0,0,0,1)).xyz - vertex.xyz;
  LW = (modelViewMatrixInverse*lightPosition).xyz - vertex.xyz;

  NE = normalMatrix*normal;
  VE = normalMatrix * VW;
  LE = normalMatrix * LW;//lightPosition.xyz-P;
  gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
