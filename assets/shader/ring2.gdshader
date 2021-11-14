shader_type canvas_item;

uniform float p1 = .5;
uniform float p2 = 0.1;

void fragment() {
	float d = length(UV - vec2(.5));
	COLOR = vec4(pow(p2 * 0.1,2.) / pow(d-p1*0.1, 2.));
	COLOR = clamp(COLOR, vec4(0.), vec4(1.));
}