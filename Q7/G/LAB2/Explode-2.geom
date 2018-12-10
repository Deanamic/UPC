#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
in vec3 N[];

uniform float speed = 0.5;
uniform float time;
uniform mat4 modelViewProjectionMatrix;
const float angSpeed = 8.0;

void main( void ) {
    vec3 M = (N[0] + N[1] + N[2]).xyz/ 3.0;
    vec4 B = vec4((gl_in[0].gl_Position + gl_in[1].gl_Position + gl_in[2].gl_Position).xyz/3.0,0);
    float a = angSpeed*time;
    mat3 Rz = mat3(vec3(cos(a), sin(a), 0),
                   vec3(-sin(a), cos(a), 0), 
                   vec3(0, 0, 1));
	for( int i = 0 ; i < 3 ; i++ ) {
		gfrontColor = vfrontColor[i];
		
		gl_Position = modelViewProjectionMatrix *
		            vec4((Rz*(gl_in[i].gl_Position - B).xyz)+B.xyz + (speed * time * M), 1.0);
		EmitVertex();
	}
    EndPrimitive();
}

