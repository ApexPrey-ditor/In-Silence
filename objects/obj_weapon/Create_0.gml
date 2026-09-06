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
energyRifleSpread = 3 + global.augments.energyRifleSpreadIncrement
energyRifleShotWidth = 3

railcannonRadiusMultiply = 2
railcannonShotWidth = 15
railcannonShotDuration = 30

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
nonpiercables = scr_get_objects_of_tag("nonpiercable")

currentWeapon = 0
weapons = global.weaponsObtained

scr_update_weapon()

function scr_process_hit(enemy, addedCharge, addedCombo) {
	if (not enemy.invulnerable) {
		enemy.hitpoints -= damage
	}
						
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
			damage = global.weaponDamage.revolver * global.damageMult
			knockback = global.knockback.revolver * global.knockbackMult
			attackDuration = ceil(global.attackDurations.revolver * global.durationsMult)
			attackCooldown = ceil(global.attackCooldowns.revolver * global.cooldownsMult)
			recoil = global.recoil.revolver * global.recoilMult
			holdShoot = false
		
			currentWeapon = 0
			sprite_index = spr_revolver
			distanceFromPlayer = global.weaponDistance.revolver
			alarm[weaponAlarms.takeOffCooldown] = attackDuration
			break
		case "grenade_launcher":
			damage = global.weaponDamage.grenadeLauncher * global.damageMult
			knockback = global.knockback.grenadeLauncher * global.knockbackMult
			attackDuration = ceil(global.attackDurations.grenadeLauncher * global.durationsMult)
			attackCooldown = ceil(global.attackCooldowns.grenadeLauncher * global.cooldownsMult)
			recoil = global.recoil.grenadeLauncher * global.recoilMult
			holdShoot = false // false
			
			currentWeapon = 1
			sprite_index = spr_grenade_launcher
			distanceFromPlayer = global.weaponDistance.grenadeLauncher
			alarm[weaponAlarms.takeOffCooldown] = attackDuration
			break
		case "energy_rifle":
			damage = global.weaponDamage.energyRifle * global.damageMult
			knockback = global.knockback.energyRifle * global.knockbackMult
			attackDuration = ceil(global.attackDurations.energyRifle * global.durationsMult)
			attackCooldown = ceil(global.attackCooldowns.energyRifle * global.cooldownsMult)
			recoil = global.recoil.energyRifle * global.recoilMult
			holdShoot = true
			
			energyRifleShotWidth = 3 + global.augments.energyRifleSpreadIncrement
			
			currentWeapon = 2
			sprite_index = spr_energy_rifle
			distanceFromPlayer = global.weaponDistance.energyRifle
			alarm[weaponAlarms.takeOffCooldown] = attackDuration
			break
		case "railcannon":
			damage = global.weaponDamage.railcannon * global.damageMult
			knockback = global.knockback.railcannon * global.knockbackMult
			attackDuration = ceil(global.attackDurations.railcannon * global.durationsMult)
			attackCooldown = ceil(global.attackCooldowns.railcannon * global.cooldownsMult)
			recoil = global.recoil.railcannon * global.recoilMult
			holdShoot = false
			
			currentWeapon = 3
			sprite_index = spr_railcannon
			distanceFromPlayer = global.weaponDistance.railcannon
			alarm[weaponAlarms.takeOffCooldown] = attackDuration
			break
		case "debug_gun":
			damage = 9999
			knockback = 10
			attackDuration = 1
			attackCooldown = 1
			recoil =3
			holdShoot = true
			
			currentWeapon = 4
			sprite_index = spr_dubug_gun
			distanceFromPlayer = 48
			alarm[weaponAlarms.takeOffCooldown] = attackDuration
			break
	}
}