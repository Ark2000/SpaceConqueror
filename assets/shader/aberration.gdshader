shader_type canvas_item;
render_mode unshaded;

uniform sampler2D mask;
uniform float p: hint_range(-0.1, 0.1);

void fragment () {
	vec4 color = vec4(1.0);
	
	float v = (texture(mask, UV).r +texture(mask, UV).g + texture(mask, UV).b) / 3.0;


	color.r = texture(SCREEN_TEXTURE, SCREEN_UV - vec2(p * v,0.0)).r;
	color.g = texture(SCREEN_TEXTURE, SCREEN_UV).g;
	color.b = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(p * v,0.0)).b;
	COLOR = color;
}