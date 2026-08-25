if (y > room_height / 2) {
	instance_destroy()
	
	global.comboKills += 1
	scr_add_combo("outOfBounds")
}