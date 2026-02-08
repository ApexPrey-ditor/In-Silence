distanceFromPlayer = 48
directionPointing = 0
canAttack = true
attacking = false

parryables = [obj_enemy_parent, obj_destructable]

damage = {
	stabilizer : 5
}

enum weaponAlarms {
	notAttacking,
	takeOffCooldown
}

enum attackDurations {
	stabilizer = 10
}

enum attackCooldowns {
	stabilizer = 20
}

enum recoil {
	stabilizer = 10
}

enum weaponDistance {
	stabilizer = 24
}

function scr_update_weapon() {
	switch (weaponSelected) {
		case "stabilizer":
			sprite_index = spr_stabilizer
			distanceFromPlayer = weaponDistance.stabilizer
			break
	}
}