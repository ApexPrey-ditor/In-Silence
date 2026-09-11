draw_self()

if (distance_to_object(obj_player) < requiredProximity and talkable) {
	draw_set_colour(c_black)
	
	draw_text(x, y - 32, "Press \"F\" to interact")
}

scr_reset_draw()