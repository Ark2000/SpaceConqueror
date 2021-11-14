shader_type canvas_item;

void fragment() {
	vec4 c2 = texture(TEXTURE, UV);
	c2.b *= UV.x;
	c2.r *= UV.y;
	c2.a = c2.r * 2.0;
	c2.rgb *= 2.0;

	c2 = clamp(c2, vec4(0.), vec4(1.));
	
	COLOR = c2;
}