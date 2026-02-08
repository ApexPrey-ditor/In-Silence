draw_set_colour(c_black)

draw_text(10, 10, xVelocity)

draw_healthbar(10, window_get_height() - 10, 60, window_get_height() - 20, hitpoints / 5 * 100, c_black, c_red, c_green, 0, true, true)