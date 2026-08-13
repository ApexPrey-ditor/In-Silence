enum weaponAlarms {
	notAttacking,
	takeOffCooldown
}

distanceFromPlayer = 48
directionPointing = 0
canAttack = true
attacking = false

shootables = scr_get_objects_of_tag("shootable")

currentWeapon = 0
weapons = global.weaponsObtained

function scr_update_weapon() {
	canAttack = false
	
	switch (weaponSelected) {
		case "revolver":
			currentWeapon = 0
			sprite_index = spr_revolver
			distanceFromPlayer = global.weaponDistance.revolver
			alarm[weaponAlarms.takeOffCooldown] = global.attackDurations.revolver
			break
		case "grenade_launcher":
			currentWeapon = 1
			sprite_index = spr_grenade_launcher
			distanceFromPlayer = global.weaponDistance.grenadeLauncher
			alarm[weaponAlarms.takeOffCooldown] = global.attackDurations.grenadeLauncher
			break
	}
}