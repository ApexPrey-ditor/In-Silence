draw_set_colour(c_black)

draw_text(10, 10, xVelocity)
draw_text(10, 25, grav)

var _cameraHeight = view_get_hport(view_current)

draw_healthbar(10, _cameraHeight - 10, 60, _cameraHeight - 20, hitpoints / 5 * 100, c_black, c_red, c_green, 0, true, true)

draw_healthbar(10, _cameraHeight - 25, 10 + 50/3, _cameraHeight - 35, stamina * 100, c_black, c_blue, c_aqua, 0, true, true)
draw_healthbar(10 + 50/3, _cameraHeight - 25, 10 + 50/3*2, _cameraHeight - 35, (stamina - 1) * 100, c_black, c_blue, c_aqua, 0, true, true)
draw_healthbar(10 + 50/3*2, _cameraHeight - 25, 60, _cameraHeight - 35, (stamina - 2) * 100, c_black, c_blue, c_aqua, 0, true, true)