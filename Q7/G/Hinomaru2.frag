#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

vec4 RED = vec4(1,0,0,1);
vec4 WHITE = vec4(1,1,1,1);
uniform bool classic = false;

vec2 origin = vec2(0.5,0.5);

void main()
{
  	float d = distance(vtexCoord, origin);
  	if(d < 0.2) fragColor = RED;
  	else fragColor = WHITE;
}
