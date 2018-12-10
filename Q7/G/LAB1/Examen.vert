#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform mat4 modelMatrix;
uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;

uniform mat4 modelMatrixInverse;
uniform mat4 viewMatrixInverse;
uniform mat4 projectionMatrixInverse;
uniform mat4 modelViewMatrixInverse;
uniform mat4 modelViewProjectionMatrixInverse;

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position
                            // (sempre estarà en eye space)

uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular;// similar a gl_FrontMaterial.specular
uniform float matShininess;// similar a gl_FrontMaterial.shininess

uniform vec3 boundingBoxMin;// cantonada mínima de la capsa englobant
uniform vec3 boundingBoxMax;// cantonada màxima de la capsa englobant

uniform vec2 mousePosition;  // coordenades del cursor (window space)
                             // origen a la cantonada inferior esquerra

vec4 light(vec3 N, vec3 V, vec3 L) {
  N=normalize(N);
  V=normalize(V); 2
  L=normalize(L);
  vec3 R=normalize(2*dot(N, L)*N-L);
  float NdotL=max(0, dot(N, L));
  float RdotV=max(0, dot(R, V));
  float ldiff=NdotL;
  float lspec=0;
  if (NdotL>0) lspec=pow(RdotV, matShininess);
  return matAmbient*lightAmbient + matDiffuse*lightDiffuse*ldiff + matSpecular*lightSpecular*lspec;
}

void main()
{
  //Variables a Object Space
  vec3 ObjW = vertex;
  vec3 NormalW = normal;
  vec3 ObjtoCameraW= (modelViewMatrixInverse*vec4(0,0,0,1)).xyz-vertex.xyz;
  vec3 LightW = (modelViewMatrixInverse*lightPosition).xyz-vertex.xyz;

  //Variables a Eye Space
  vec3 ObjE = (modelViewMatrix*vec4(vertex.xyz, 1)).xyz;
  vec3 NormalE = normalize(normalMatrix * normal);
  vec3 ObjtoCameraE = -ObjE;
  vec3 LightE = lightPosition.xyz - P;

  frontColor = vec4(color,1.0);
  vtexCoord = texCoord;
  gl_Position = modelViewProjectionMatrix * vec4(vertex, 1.0);
}
