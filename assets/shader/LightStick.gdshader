shader_type canvas_item;

uniform float max_light = 1.;
uniform vec4 color :hint_color = vec4(1.);

uniform float p1 = 0.1;
uniform float p2 = 0.3;
uniform float p3 = 0.7;

void fragment() {
	float d = 1.;
	if (UV.x < p2) {
		d = length(UV - vec2(p2,.5));
	} else if (UV.x < p3) {
		d = UV.y-.5;
	} else {
		d = length(UV - vec2(p3,.5));
	}
	float v = (p1*p1)/(d*d);
	
	float v2 = min(max_light, v);
	COLOR = vec4(color.rgb * v2, v2);
}