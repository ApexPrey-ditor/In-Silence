upgradeDescKey = {damage : "+10% Damage",
			attackSpeed : "+10% Attack Speed",
			hitPower : "+20% Recoil and Knockback",
			moveSpeed : "+10% Move Speed",
			blockRevolver : "Block Revolver: +100% damage, -30% attack speed",
			bignade : "bignade: Increases grenade size (+50%) and explosion radius (+25%)"}
			
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
		case "blockRevolver":
			global.weaponDamage.revolver += 1
			global.cooldownsMult += 1.3
			global.durationsMult += 1.3
			break
		case "bignade":
			global.augments.grenadeExplosionRadius += 0.25
			global.augments.grenadeSize += 0.5
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