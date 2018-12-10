#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

vec4 NEGRE = vec4(0,0,0,0);
vec4 GRIS = vec4(0.8);

uniform float n = 12;
void main()
{
	int x = int((mod(vtexCoord.x*n,2)));
	int y = int((mod(vtexCoord.y*n,2)));
	int p = int(mod(mod(x + y, 2) + 2, 2));
    if(p == 1) fragColor = NEGRE;
    else fragColor = GRIS;
} 
