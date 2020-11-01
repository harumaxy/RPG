shader_type canvas_item;

uniform bool is_active = true;

void fragment() {
  vec4 previous_color = texture(TEXTURE, UV);
  vec4 white_color = vec4(1.,1.,1.,previous_color.a);
  vec4 new_color = is_active ? white_color : previous_color;
  COLOR = vec4(new_color);
}