shader_type canvas_item;

void fragment() {
	COLOR = texture(TEXTURE, vec2(1.0 - UV.x, UV.y));
}