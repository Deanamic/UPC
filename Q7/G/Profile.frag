#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec3 N;
in vec3 vtexCoord;

vec4 YELLOW = vec4(0.7,0.6,0,1);

uniform float epsilon = 0.1, light =0.5;

void main()
{
	float CdotN = dot(normalize(N), normalize(vtexCoord));
	if(abs(CdotN) < epsilon) fragColor = YELLOW;
	else fragColor = frontColor * (light * normalize(N).z);
}
