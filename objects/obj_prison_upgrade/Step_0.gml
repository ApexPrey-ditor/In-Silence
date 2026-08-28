if (place_meeting(x, y, obj_player)) {
	if (upgrade) {
		scr_apply_upgrade(upgradeKey)
	}
	else {
		scr_apply_modifier(modifier)
	}
	
	with (obj_prison_upgrade) {
		instance_destroy()
	}
}