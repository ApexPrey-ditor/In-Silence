upgrades = {damage : 0.1,
			attackSpeed : 1.1,
			hitPower : 0.2,
			moveSpeed : 0.1}

upgradeDescKey = {damage : "+10% Damage",
			attackSpeed : "+10% Attack Speed",
			hitPower : "+20% Recoil and Knockback",
			moveSpeed : "+10% Move Speed"}
			
modifiers = {easy : "Easy: Enemies level up every 5 rooms, JimBob gets an upgrade every 3 rooms.",
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
			global.damageMult += struct_get(upgrades, upgrade)
			break
		case "attackSpeed":
			global.cooldownsMult /= struct_get(upgrades, upgrade)
			global.durationsMult /= struct_get(upgrades, upgrade)
			break
		case "hitPower":
			global.recoilMult += struct_get(upgrades, upgrade)
			global.knockbackMult += struct_get(upgrades, upgrade)
			break
		case "moveSpeed":
			if (instance_exists(obj_player)) {
				obj_player.moveSpeedMult += struct_get(upgrades, upgrade)
				obj_player.scr_recalc_stats()
			}
			break
	}
	
	if (instance_exists(obj_weapon)) {
		obj_weapon.scr_update_weapon()
	}
}

function scr_apply_modifier(modifier) {
	switch (modifier) {
		case "easy":
			obj_prison_manager.enemyLevelUpRoom = 5
			obj_prison_manager.playerLevelUpRoom = 3
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