upgrades = {damage : "+10% Damage",
			attackSpeed : "+10% Attack Speed",
			hitPower : "+20% Recoil and Knockback",
			moveSpeed : "+10% Move Speed",
			sawedOff : "Sawed Off: +25% attack speed, -15% range",
			blockRevolver : "Block Revolver: +100% damage, -30% attack speed",
			bignade : "Bignade: Increases grenade size (+50%) and explosion radius (+25%)",
			erraticRifle : "Erratic Rifle: Increases energy rifle spread (+2) and damage (+25%)",
			lowEnergyCannon : "Low Energy Cannon: Decrease railcannon charge requirement (-10%)"}
			
modifiers = {simple : "Simple: Endless rooms, endless rooms.",
			normal : "Default: Enemies level up every 3 rooms, JimBob gets an upgrade every 5 rooms.",
			chaos : "Chaos: Enemies level up every room, Jimbob gets an upgrade every room.",
			hardcore : "Hardcore: Enemies level up every 3 rooms, JimBob gets no upgrades."}

if (upgrade) {
	upgradeKey = struct_get_names(upgrades)[irandom_range(0, array_length(struct_get_names(upgrades)) - 1)]
}
else {
	modifier = struct_get_names(modifiers)[modifier]
}

function scr_apply_upgrade(upgrade) {
	switch (upgrade) {
		case "damage":
			global.damageMult += 0.1
			break
		case "attackSpeed":
			global.cooldownsMult /= 1.1
			global.durationsMult /= 1.1
			break
		case "hitPower":
			global.recoilMult += 0.2
			global.knockbackMult += 0.2
			break
		case "moveSpeed":
			if (instance_exists(obj_player)) {
				obj_player.moveSpeedMult += 0.1
				obj_player.scr_recalc_stats()
			}
			break
		case "sawedOff":
			global.attackCooldowns.shotgun /= 1.25
			global.augments.shotgunRangeMultiplier /= 1.15
			break
		case "blockRevolver":
			global.weaponDamage.revolver *= 2
			global.attackCooldowns.revolver *= 1.3
			global.attackDurations.revolver *= 1.3
			break
		case "bignade":
			global.augments.grenadeExplosionRadiusMultiplier += 0.25
			global.augments.grenadeSizeMultiplier += 0.5
			break
		case "erraticRifle":
			global.weaponDamage.energyRifle *= 1.25
			global.augments.energyRifleSpreadIncrement += 2
			break
		case "lowEnergyCannon":
			global.railcannonChargeRequirement -= 1
			break
	}
	
	if (instance_exists(obj_weapon)) {
		obj_weapon.scr_update_weapon()
	}
}

function scr_apply_modifier(modifier) {
	switch (modifier) {
		case "simple":
			obj_prison_manager.enemyLevelUpRoom = infinity
			obj_prison_manager.playerLevelUpRoom = infinity
			break
		case "normal":
			obj_prison_manager.enemyLevelUpRoom = 3
			obj_prison_manager.playerLevelUpRoom = 5
			break
		case "chaos":
			obj_prison_manager.enemyLevelUpRoom = 1
			obj_prison_manager.playerLevelUpRoom = 1
			break
		case "hardcore":
			obj_prison_manager.enemyLevelUpRoom = 3
			obj_prison_manager.playerLevelUpRoom = infinity
			break
	}
}