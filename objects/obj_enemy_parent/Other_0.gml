if (y < 0 or y > room_height) {
	instance_destroy()

	global.comboKills += 1
	scr_add_combo("outOfBounds")
}