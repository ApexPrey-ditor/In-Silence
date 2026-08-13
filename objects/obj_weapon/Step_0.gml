if (instance_exists(obj_player)) {
	if (!attacking) {
		directionPointing = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y)
		image_angle = directionPointing
		
		image_yscale = scr_find_angle_x_direction(directionPointing)
		
		if (scr_keyboard_check_keys_pressed(obj_player.keybinds.switchWeapon)) {
			if (currentWeapon + 1 < array_length(weapons)) {
				weaponSelected = weapons[currentWeapon + 1]
			}
			else {
				weaponSelected = weapons[0]
			}
			
			scr_update_weapon()
		}
	}
	
	x = obj_player.x + (dcos(directionPointing) * distanceFromPlayer)
	y = obj_player.y - (dsin(directionPointing) * distanceFromPlayer)
	
	if (mouse_check_button_pressed(obj_player.keybinds.shoot) and canAttack) {
		canAttack = false
		attacking = true
		
		switch weaponSelected {
			case "revolver":
				alarm[weaponAlarms.notAttacking] = global.attackDurations.revolver
				alarm[weaponAlarms.takeOffCooldown] = global.attackCooldowns.revolver
				
				// recoil
				obj_player.xVelocity -= global.recoil.revolver * dcos(directionPointing)
				obj_player.grav += global.recoil.revolver * dsin(directionPointing)
				
				var hitX = x
				var hitY = y
				
				var xIncrease = dcos(directionPointing)
				var yIncrease = -dsin(directionPointing)
				
				while (!position_meeting(hitX, hitY, shootables) and
						hitX > 0 and hitX < room_width and
						hitY > 0 and hitY < room_height) {
					hitX += xIncrease
					hitY += yIncrease
				}
				
				var targetedObject = instance_position(hitX, hitY, shootables)
				
				if (instance_exists(targetedObject)) {
					if (object_is_ancestor(targetedObject.object_index, obj_enemy_parent)) {
						targetedObject.hitpoints -= global.weaponDamage.revolver
					}
					else if (targetedObject.object_index == obj_destructable) {
						instance_destroy(targetedObject)
					}
					else if (targetedObject.object_index == obj_target) {
						with (targetedObject) {
							scr_trigger_target()
						}
					}
				}
				
				instance_create_layer(x, y, "Weapons", obj_visual_projectile, {endX : hitX, endY : hitY})
				
				break
			case "grenade_launcher":
				alarm[weaponAlarms.notAttacking] = global.attackDurations.grenadeLauncher
				alarm[weaponAlarms.takeOffCooldown] = global.attackCooldowns.grenadeLauncher
				
				// recoil
				obj_player.xVelocity -= global.recoil.grenadeLauncher * dcos(directionPointing)
				obj_player.grav += global.recoil.grenadeLauncher * dsin(directionPointing)
				
				instance_create_layer(x, y, layer, obj_weapon_projectile, {direction : directionPointing, speed : clamp(distance_to_point(mouse_x, mouse_y) / 20, 5, 20)})
				break
		}
	}
}