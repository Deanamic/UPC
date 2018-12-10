#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec3 vtexCoord;

void main()
{
	vec3 N = cross(dFdx(vtexCoord),dFdy(vtexCoord));
    fragColor = frontColor * normalize(N).z;
}
