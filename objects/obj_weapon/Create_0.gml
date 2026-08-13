enum weaponAlarms {
	notAttacking,
	takeOffCooldown
}

distanceFromPlayer = 48
directionPointing = 0
canAttack = true
attacking = false

shootables = [obj_enemy_parent, obj_destructable, obj_solid_hitbox, obj_target]

function scr_update_weapon() {
	canAttack = false
	
	switch (weaponSelected) {
		case "revolver":
			sprite_index = spr_revolver
			distanceFromPlayer = global.weaponDistance.revolver
			alarm[weaponAlarms.takeOffCooldown] = global.attackCooldowns.revolver
		case "grenadeLauncher":
			sprite_index = spr_grenade_launcher
			distanceFromPlayer = global.weaponDistance.grenadeLauncher
			alarm[weaponAlarms.takeOffCooldown] = global.attackCooldowns.grenadeLauncher
	}
}