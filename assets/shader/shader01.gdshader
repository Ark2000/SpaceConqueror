shader_type canvas_item;

uniform float len = 1.0;

void fragment() {
	vec4 c1 = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 c2 = texture(TEXTURE, UV);
	float a = smoothstep(0.0, 0.1, UV.x) - smoothstep(len - 0.1, len, UV.x);
	COLOR = c1 + c2;
	COLOR.a = a;
}