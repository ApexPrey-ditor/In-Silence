if (place_meeting(x, y, obj_player)) {
	if (weapon == "stabilizer") {
		global.stabilizerObtained = true
		if (!instance_exists(obj_shotgun)) {
			instance_create_layer(obj_player.x, obj_player.y, "Weapons", obj_shotgun)
		}
	}
	else {
		array_union(global.weaponsObtained, [weapon])
		if (instance_exists(obj_weapon)) {
			obj_weapon.weaponSelected = weapon
		}
		else {
			instance_create_layer(obj_player.x, obj_player.y, "Weapons", obj_weapon, {weaponSelected : weapon})
		}
		with (obj_weapon) {
			scr_update_weapon()
		}
	}
	instance_destroy()
}