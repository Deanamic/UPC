#version 330 core

in vec4 frontColor;
out vec4 fragColor;

in vec2 vtexCoord;
uniform sampler2D map;
uniform float time;
uniform float a = 0.5;

void main()
{
  vec4 T = texture(map, vtexCoord);
  float m = max(T.x, max(T.y,T.z));
  vec2 u = vec2(m, m);
  float ang = 2 * acos(-1) * time;
  mat2 Rot = mat2(vec2(cos(ang), sin(ang)), vec2(-sin(ang), cos(ang)));
  u = Rot*u;
  vec2 offset = (a/100.0) * u;
  fragColor = texture(texture(map, vtexCoord + offset));
}
