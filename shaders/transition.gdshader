shader_type canvas_item;
render_mode unshaded;

uniform float radius: hint_range(0.0, 1.2);
uniform vec2 pos;
const float ASPECT_RATIO = 1920.0 / 1080.0;

void fragment() {
	vec2 uv = UV - pos;
	uv.x *= ASPECT_RATIO;
	float a = 1.0;
	if (length(uv) > radius) {
		a = 1.0;
	} else {
		a = 0.0;
	}

	COLOR = vec4(vec3(0.0), a);
}