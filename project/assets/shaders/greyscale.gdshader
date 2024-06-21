shader_type canvas_item;

uniform float intensity = 0.75;

void fragment() {
	float greyscale = (COLOR.r + COLOR.g + COLOR.b) / 3.0 * intensity;
	COLOR = vec4(greyscale, greyscale, greyscale, COLOR.a);
}
