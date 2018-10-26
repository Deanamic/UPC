#version 330 core

in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;

void main()
{
	vec4 col[2];
	col[1] = vec4(1,0,0,1);
	col[0] = vec4(1,1,0,1);
	float f = fract(vtexCoord.s);
	float a = 1./9.;
	float cur = a;
	for(int i = 0; i < 9; ++i) {
		if(f < cur) {
			fragColor = col[i%2];
			break;
		}
		cur += a;
	}
}

