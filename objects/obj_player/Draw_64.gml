draw_set_colour(c_black)

draw_text(10, 10, xVelocity)
draw_text(10, 25, grav)

draw_healthbar(10, view_get_hport(view_current) - 10, 60, view_get_hport(view_current) - 20, hitpoints / 5 * 100, c_black, c_red, c_green, 0, true, true)