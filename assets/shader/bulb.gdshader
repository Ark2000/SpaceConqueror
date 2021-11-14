shader_type canvas_item;

uniform float r:hint_range(0.0,4.0) = 1.0;
uniform float g:hint_range(0.0,4.0) = 1.0;
uniform float b:hint_range(0.0,4.0) = 1.0;
uniform float p1 = 1.0;
uniform float p2 = 0.1;
uniform float p3 = 1.0;

void fragment() {
	float d = length(UV-vec2(.5));
	float a = 0.00004*p3/(d*d*d);
	float n = fract(sin(TIME*100.0));

	COLOR = vec4(vec3(1.)*vec3(r,g,b)*p1,clamp(a * (1.0 + n * p2),0.,1.));
}