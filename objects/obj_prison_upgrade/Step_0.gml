if (place_meeting(x, y, obj_player)) {
	scr_apply_upgrade(upgradeKey)
	
	with (obj_prison_upgrade) {
		instance_destroy()
	}
}