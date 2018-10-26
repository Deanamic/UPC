#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;

vec4 NEGRE = vec4(1,0,0,0);
vec4 GRIS = vec4(0.8,0.8,0.8,1);

uniform float n = 12;

void main()
{
  	float x=fract(vtexCoord.x*n);
	float y=fract(vtexCoord.y*n);
    if(x < 0.1 || y < 0.1) fragColor = NEGRE;
    else discard;
}

