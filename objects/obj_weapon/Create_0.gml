enum weaponAlarms {
	notAttacking,
	takeOffCooldown
}

revolverChargeAdd = 1
revolverShotWidth = 5

grenadeSpeedMin = 5
grenadeSpeedMax = 20
grenadeSpeedDivisor = 20

energyRifleChargeAdd = 0.2
energyRifleSpeedAdd = 2
energyRifleSpread = 3
energyRifleShotWidth = 3

railcannonRadiusMultiply = 2
railcannonShotWidth = 15
railcannonShotDuration = 12

blasterSpread = 5
blasterChargeAdd = 0.1

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
solids = scr_get_objects_of_tag("solid")

currentWeapon = 0
weapons = global.weaponsObtained

scr_update_weapon()

function scr_process_hit(enemy, addedCharge, addedCombo) {
	enemy.hitpoints -= damage
						
	// knockback
	enemy.xVelocity += knockback * dcos(directionPointing)
	enemy.grav -= knockback * dsin(directionPointing)
	
	with (enemy) {
		event_user(enemyUserEvents.globalDetect)
	}
						
	global.railcannonCharge += addedCharge
	scr_add_combo(addedCombo)
}

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
			holdShoot = false // false
			
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
		case "railcannon":
			damage = global.weaponDamage.railcannon
			knockback = global.knockback.railcannon
			attackDuration = global.attackDurations.railcannon
			attackCooldown = global.attackCooldowns.railcannon
			recoil = global.recoil.railcannon
			holdShoot = false
			
			currentWeapon = 3
			sprite_index = spr_railcannon
			distanceFromPlayer = global.weaponDistance.railcannon
			alarm[weaponAlarms.takeOffCooldown] = global.attackDurations.railcannon
			break
		case "blaster":
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
	}
}