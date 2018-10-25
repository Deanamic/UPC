#version 330 core

in vec4 frontColor;
out vec4 fragColor;
in vec2 vtexCoord;
uniform sampler2D colorMap;
uniform sampler2D explosion;
uniform float time;
void main(){
    int t = int(30*time);
    t = t % 48;
    int c = t%8;
    int r = 5 - t/8;
    vec2 texCoord = vtexCoord*(vec2(1./8, 1./6));
    texCoord.x += c/8.;
    texCoord.y += r/6.;
    fragColor = texture(explosion, texCoord);
    fragColor *= fragColor.w;
}
