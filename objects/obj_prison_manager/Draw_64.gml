draw_set_colour(c_black)

draw_text(10, 10, "Level: " + string(ceil(roomNumber / 3)))
draw_text(10, 35, "Room: " + string(roomNumber))

scr_reset_draw()