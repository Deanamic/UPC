#version 330 core

in vec3 N;
in vec4 frontColor;
out vec4 fragColor;

void main()
{
    vec3 Nor = normalize(N);
    fragColor = frontColor*Nor.z;
    
}
