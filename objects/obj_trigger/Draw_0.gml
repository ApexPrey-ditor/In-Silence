draw_self()

if (trigger == "interact" and place_meeting(x, y, obj_player)) {
	draw_text(x, y - 32, "Press \"F\" to interact")
}