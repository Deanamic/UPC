#version 330 core

in vec4 frontColor;
out vec4 fragColor;

uniform vec4 lightAmbient; // similar a gl_LightSource[0].ambient
uniform vec4 lightDiffuse; // similar a gl_LightSource[0].diffuse
uniform vec4 lightSpecular; // similar a gl_LightSource[0].specular
uniform vec4 lightPosition; // similar a gl_LightSource[0].position
                            // (sempre estarà en eye space)

uniform vec4 matAmbient; // similar a gl_FrontMaterial.ambient
uniform vec4 matDiffuse; // similar a gl_FrontMaterial.diffuse
uniform vec4 matSpecular;// similar a gl_FrontMaterial.specular
uniform float matShininess;// similar a gl_FrontMaterial.shininess

in vec3 N;
in vec3 P;
void main()
{
  vec3 Nor = normalize(N);
  vec3 V = normalize(-P);
  vec3 L = normalize(lightPosition.xyz - P);
  vec3 R = normalize(2*(dot(Nor,L))*Nor-L);
  float NdotL = max(0., dot(Nor,L));
  float RdotV = max(0, dot(R,V));
  float ldiff = NdotL;
  float lspec = 0;
  if(NdotL > 0) lspec = pow(RdotV, matShininess);
  fragColor = matAmbient*lightAmbient + matDiffuse*lightDiffuse*ldiff + matSpecular*lightSpecular*lspec;
}
