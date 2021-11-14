shader_type canvas_item;

uniform float p1 = 0.2;
uniform float p2 = 0.1;

float nrand( vec2 n )
{
	return fract(sin(dot(n.xy, vec2(12.9898, 78.233)))* 43758.5453);
}

float n1rand( vec2 n, float t)
{
	t = fract(t);
	float nrnd0 = nrand( n + 0.07*t );
	return nrnd0;
}

void fragment() {
	float d = length(UV - vec2(.5)) - p1;
	float a = p2 / (d * d) / 1000.0 * (2.0 + n1rand(vec2(.0), TIME)*4.0);
	if (d < 0.0) {
		a *= 200.0;
	}
	COLOR = vec4(vec3(1.0, 0.3, 0.3) * max(1.0, a), min(a,1.0));
	COLOR = min(COLOR, vec4(1.2));
}