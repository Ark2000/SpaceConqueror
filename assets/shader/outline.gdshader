shader_type canvas_item;

uniform vec4 line_color : hint_color = vec4(1);
uniform float line_thickness : hint_range(0, 10) = 1.0;
uniform float line_multiplier = 0.0;

void fragment() {
	vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
	
	float outline = texture(TEXTURE, UV + vec2(-size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, 0)).a;
	outline += texture(TEXTURE, UV + vec2(0, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, size.y)).a;
	outline += texture(TEXTURE, UV + vec2(-size.x, -size.y)).a;
	outline += texture(TEXTURE, UV + vec2(size.x, -size.y)).a;
	
	vec4 color = texture(TEXTURE, UV);
	vec4 col2 = mix(color, line_color, min(outline,1.0) - color.a);

	float mask = smoothstep(0.5, 1.5, outline) - smoothstep(3.0, 4.0, outline);
	
	col2.rgb *= (mask * line_multiplier + 1.0);

	COLOR = col2;
}