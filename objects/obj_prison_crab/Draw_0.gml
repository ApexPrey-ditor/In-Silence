draw_self()

if (drawParryFlash) {
	var _parryColors = [c_blue, c_yellow]
	
	draw_set_colour(_parryColors[parryablePunch])
	draw_rectangle(x - 10, y - 10, x + 10, y + 10, false)
}

scr_reset_draw()