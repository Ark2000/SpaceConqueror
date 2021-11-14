shader_type canvas_item;

uniform float max_light = 1.;
uniform vec4 color :hint_color = vec4(1.);

uniform float p1 = 0.1;
uniform float p2 = 0.3;
uniform float p3 = 0.7;

uniform float r = 0.1;

void fragment() {
	vec2 pos = vec2(p2, .5);
	
	float d = 1.;
	if (UV.x < p2) {
		d = length(UV - vec2(p2,.5));
	} else if (UV.x < p3) {
		d = UV.y-.5;
	} else {
		d = length(UV - vec2(p3,.5));
	}
	float v = (p1*p1)/(d*d);
	
	vec2 a = UV - pos;
	float d2 = dot(a, a);
	float v1 = (r*r)/d2;
	
	float v2 = min(max_light, v+v1);
	COLOR = vec4(color.rgb * v2, v2);
	COLOR = clamp(COLOR, vec4(0.), vec4(1.4));
}