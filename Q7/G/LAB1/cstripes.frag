#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

vec4 RED = vec4(1,0,0,1);
vec4 YELLOW = vec4(1,1,0,1);

uniform int nstripes = 16;
uniform vec2 origin = vec2(0,0);

void main()
{
  	float d = distance(vtexCoord, origin);
  	d *= nstripes;
  	int r = int(d);
  	if(int(mod(d,2)) == 0) fragColor = RED;
  	else fragColor = YELLOW;
}
