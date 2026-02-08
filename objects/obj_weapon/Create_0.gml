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
			distanceFromPlayer = weaponDistance.revolver
			alarm[weaponAlarms.takeOffCooldown] = attackCooldowns.stabilizer
	}
}