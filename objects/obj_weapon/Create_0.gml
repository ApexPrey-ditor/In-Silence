enum weaponAlarms {
	notAttacking,
	takeOffCooldown
}

grenadeSpeedMin = 5
grenadeSpeedMax = 20
grenadeSpeedDivisor = 20

energyRifleSpeedAdd = 2
energyRifleSpread = 3

distanceFromPlayer = 48
directionPointing = 0
canAttack = true
attacking = false
holdShoot = false

damage = 0
knockback = 0
attackDuration = 0
attackCooldown = 0
recoil = 0

shootables = scr_get_objects_of_tag("shootable")

currentWeapon = 0
weapons = global.weaponsObtained

scr_update_weapon()

function scr_update_weapon() {
	canAttack = false
	
	switch (weaponSelected) {
		case "revolver":
			damage = global.weaponDamage.revolver
			knockback = global.knockback.revolver
			attackDuration = global.attackDurations.revolver
			attackCooldown = global.attackCooldowns.revolver
			recoil = global.recoil.revolver
			holdShoot = false
		
			currentWeapon = 0
			sprite_index = spr_revolver
			distanceFromPlayer = global.weaponDistance.revolver
			alarm[weaponAlarms.takeOffCooldown] = attackDuration
			break
		case "grenade_launcher":
			damage = global.weaponDamage.grenadeLauncher
			knockback = global.knockback.grenadeLauncher
			attackDuration = global.attackDurations.grenadeLauncher
			attackCooldown = global.attackCooldowns.grenadeLauncher
			recoil = global.recoil.grenadeLauncher
			holdShoot = false
			
			currentWeapon = 1
			sprite_index = spr_grenade_launcher
			distanceFromPlayer = global.weaponDistance.grenadeLauncher
			alarm[weaponAlarms.takeOffCooldown] = global.attackDurations.grenadeLauncher
			break
		case "energy_rifle":
			damage = global.weaponDamage.energyRifle
			knockback = global.knockback.energyRifle
			attackDuration = global.attackDurations.energyRifle
			attackCooldown = global.attackCooldowns.energyRifle
			recoil = global.recoil.energyRifle
			holdShoot = true
			
			currentWeapon = 2
			sprite_index = spr_energy_rifle
			distanceFromPlayer = global.weaponDistance.energyRifle
			alarm[weaponAlarms.takeOffCooldown] = global.attackDurations.energyRifle
			break
	}
}