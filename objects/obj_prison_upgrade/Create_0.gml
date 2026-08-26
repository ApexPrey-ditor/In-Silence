upgrades = {damage : 0.1,
			attackSpeed : 1.1,
			hitPower : 0.2,
			moveSpeed : 0.1}

descKey = {damage : "+10% Damage",
			attackSpeed : "+10% Attack Speed",
			hitPower : "+20% Recoil and Knockback",
			moveSpeed : "+10% Move Speed"}

upgradeKey = struct_get_names(upgrades)[irandom_range(0, array_length(struct_get_names(upgrades)) - 1)]

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
			show_debug_message("RAAAAAAAAAAAAAAA")
			if (instance_exists(obj_player)) {
				obj_player.moveSpeedMult += struct_get(upgrades, upgrade)
				obj_player.scr_reset_player()
			}
			break
	}
}