shader_type canvas_item;

const vec2 c = vec2(0.5, 0.5);
uniform float force = 0.1;
uniform float outer_radius = 0.3;
uniform float thickness = 0.1;
uniform float soft_edge = 0.02;

void fragment() {
	float mask = smoothstep(outer_radius-thickness-soft_edge,outer_radius-thickness+soft_edge,length(UV - c)) - smoothstep(outer_radius-soft_edge,outer_radius+soft_edge,length(UV-c));
	vec2 disp = normalize(UV - c) * force * mask;
	vec4 col = texture(SCREEN_TEXTURE, SCREEN_UV - disp);
	COLOR = col;
}