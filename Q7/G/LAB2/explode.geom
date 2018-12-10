#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices = 36) out;

in vec4 vfrontColor[];
out vec4 gfrontColor;
in vec3 N[];

uniform float speed = 0.5;
uniform float time;
uniform mat4 modelViewProjectionMatrix;

void main( void ) {
    vec3 M = (N[0] + N[1] + N[2]).xyz/ 3.0;
	for( int i = 0 ; i < 3 ; i++ ) {
		gfrontColor = vfrontColor[i];
		
		gl_Position = modelViewProjectionMatrix *
		            vec4(gl_in[i].gl_Position.xyz + (speed * time * M), 1.0);
		EmitVertex();
	}
    EndPrimitive();
}

/*
#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices=36) out;

uniform mat4 modelViewProjectionMatrix;

uniform float time;

const float speed=0.5;

in vec4 vfrontColor[];
in vec3 vnormal[];
out vec4 gfrontColor;

void main(void) {
  vec3 N=speed*time*(vnormal[0]+vnormal[1]+vnormal[2])/3;
  for (int i=0; i<3; ++i) { 
    gfrontColor=vfrontColor[i]; 
    vec3 V=gl_in[i].gl_Position.xyz+N;
    gl_Position=modelViewProjectionMatrix*vec4(V, 1);
    EmitVertex();
  }
  EndPrimitive();
}
*/
