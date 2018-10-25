#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;

uniform float time;
uniform float slice = 0.1;
uniform sampler2D sampler0, sampler1, sampler2, sampler3;

void main()
{
	int t = int(mod(time / slice, 4));
	if(t == 0) fragColor = texture(sampler0, vtexCoord);
	if(t == 1) fragColor = texture(sampler1, vtexCoord);
	if(t == 2) fragColor = texture(sampler2, vtexCoord);
	if(t == 3) fragColor = texture(sampler3, vtexCoord);
	//fragColor *= fragColor.w;
}
