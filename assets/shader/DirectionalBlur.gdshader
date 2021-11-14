shader_type canvas_item;

uniform int Samples = 32; //multiple of 2
uniform float Intensity = 0.0;
uniform float angle = 0.0;

vec4 DirectionalBlur(in vec2 uv, in vec2 Direction, in float intensity, in sampler2D Texture)
{
    vec4 Color = vec4(0.0);  
    
    for (int i=1; i<=Samples/2; i++) {
    	Color += texture(Texture,uv+float(i)*intensity/float(Samples/2)*Direction);
    	Color += texture(Texture,uv-float(i)*intensity/float(Samples/2)*Direction);
    }  
    return Color/float(Samples);    
}

void fragment() {
    vec2 Direction = vec2(-sin(angle),cos(angle));    
    vec4 Color = DirectionalBlur(UV,normalize(Direction),Intensity,TEXTURE);
    
	COLOR = Color;
}