if (instance_exists(obj_player)) {
	if (!attacking) {
		directionPointing = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y)
		image_angle = directionPointing
		
		image_yscale = scr_find_angle_x_direction(directionPointing)
		
		if (scr_input_check_pressed(obj_player.keybinds.switchWeapon)) {
			if (currentWeapon + 1 < array_length(weapons)) {
				weaponSelected = weapons[currentWeapon + 1]
			}
			else {
				weaponSelected = weapons[0]
			}
			
			scr_update_weapon()
		}
		if (scr_input_check_pressed(obj_player.keybinds.switchBackwards)) {
			if (currentWeapon - 1 > -1) {
				weaponSelected = weapons[currentWeapon - 1]
			}
			else {
				weaponSelected = weapons[array_length(weapons) - 1]
			}
			
			scr_update_weapon()
		}
	}
	
	x = obj_player.x + (dcos(directionPointing) * distanceFromPlayer)
	y = obj_player.y - (dsin(directionPointing) * distanceFromPlayer)
	
	if ((scr_input_check_pressed(obj_player.keybinds.shoot) or (scr_input_check(obj_player.keybinds.shoot) and holdShoot))
			and canAttack
			and (weaponSelected != "railcannon" or global.railcannonCharge >= global.railcannonChargeRequirement)) {
		canAttack = false
		attacking = true
		
		with (obj_enemy_parent) {
			scr_test_sound_detection(other.x, other.y)
		}
		
		var hitX = 0
		var hitY = 0
				
		var xIncrease = 0
		var yIncrease = 0
		
		var targetedObject = noone
		
		switch weaponSelected {
			case "revolver":
				alarm[weaponAlarms.notAttacking] = attackDuration
				alarm[weaponAlarms.takeOffCooldown] = attackCooldown
				
				// recoil
				obj_player.xVelocity -= recoil * dcos(directionPointing)
				obj_player.grav += recoil * dsin(directionPointing)
				
				hitX = x
				hitY = y
				
				xIncrease = dcos(directionPointing)
				yIncrease = -dsin(directionPointing)
				
				while (!position_meeting(hitX, hitY, shootables) and
						hitX > 0 and hitX < room_width and
						hitY > 0 and hitY < room_height) {
					hitX += xIncrease
					hitY += yIncrease
				}
				
				targetedObject = instance_position(hitX, hitY, shootables)
				
				if (instance_exists(targetedObject)) {
					if (object_is_ancestor(targetedObject.object_index, obj_enemy_parent)) {
						// enemy
						scr_process_hit(targetedObject, revolverChargeAdd, "baseRevolver")
					}
					else if (targetedObject.object_index == obj_destructable) {
						instance_destroy(targetedObject)
					}
					else if (targetedObject.object_index == obj_target) {
						with (targetedObject) {
							scr_trigger_target()
						}
					}
					else if (targetedObject.object_index == obj_grenade) {
						with (targetedObject) {
							damage += other.damage
							scr_detonate_grenade()
						}
					}
				}
				
				instance_create_layer(x, y, layer, obj_visual_projectile, {endX : hitX, endY : hitY, width : revolverShotWidth})
				
				break
			case "grenade_launcher":
				alarm[weaponAlarms.notAttacking] = attackDuration
				alarm[weaponAlarms.takeOffCooldown] = attackCooldown
				
				// recoil
				obj_player.xVelocity -= recoil * dcos(directionPointing)
				obj_player.grav += recoil * dsin(directionPointing)
				
				instance_create_layer(x, y, layer, obj_grenade, {direction : directionPointing, speed : clamp(distance_to_point(mouse_x, mouse_y) / grenadeSpeedDivisor, grenadeSpeedMin, grenadeSpeedMax), damage : damage})
				break
			case "energy_rifle":
				alarm[weaponAlarms.notAttacking] = attackDuration
				alarm[weaponAlarms.takeOffCooldown] = attackCooldown
				
				directionPointing += random_range(-energyRifleSpread, energyRifleSpread)
				
				// recoil
				obj_player.xVelocity -= recoil * dcos(directionPointing)
				obj_player.grav += recoil * dsin(directionPointing)
				
				hitX = x
				hitY = y
				
				xIncrease = dcos(directionPointing)
				yIncrease = -dsin(directionPointing)
				
				while (!position_meeting(hitX, hitY, shootables) and
						hitX > 0 and hitX < room_width and
						hitY > 0 and hitY < room_height) {
					hitX += xIncrease
					hitY += yIncrease
				}
				
				targetedObject = instance_position(hitX, hitY, shootables)
				
				if (instance_exists(targetedObject)) {
					if (object_is_ancestor(targetedObject.object_index, obj_enemy_parent)) {
						// enemy
						scr_process_hit(targetedObject, energyRifleChargeAdd, "baseEnergyRifle")
					}
					else if (targetedObject.object_index == obj_destructable) {
						instance_destroy(targetedObject)
					}
					else if (targetedObject.object_index == obj_target) {
						with (targetedObject) {
							scr_trigger_target()
						}
					}
					else if (targetedObject.object_index == obj_grenade) {
						with (targetedObject) {
							scr_add_speed(other.energyRifleSpeedAdd, other.directionPointing)
						}
					}
				}
				
				instance_create_layer(x, y, layer, obj_visual_projectile, {endX : hitX, endY : hitY, width : energyRifleShotWidth})
				
				break
			case "railcannon":
				alarm[weaponAlarms.notAttacking] = attackDuration
				alarm[weaponAlarms.takeOffCooldown] = attackCooldown
				
				global.railcannonCharge = 0
				
				// recoil
				obj_player.xVelocity -= recoil * dcos(directionPointing)
				obj_player.grav += recoil * dsin(directionPointing)
				
				hitX = x
				hitY = y
				
				xIncrease = dcos(directionPointing)
				yIncrease = -dsin(directionPointing)
				
				while (!position_meeting(hitX, hitY, shootables) and
						hitX > 0 and hitX < room_width and
						hitY > 0 and hitY < room_height) {
					hitX += xIncrease
					hitY += yIncrease
				}
				
				targetedObject = instance_position(hitX, hitY, shootables)
				
				if (instance_exists(targetedObject)) {
					if (object_is_ancestor(targetedObject.object_index, obj_enemy_parent)) {
						// enemy
						scr_process_hit(targetedObject, 0, "baseRailcannon")
					}
					else if (targetedObject.object_index == obj_destructable) {
						instance_destroy(targetedObject)
					}
					else if (targetedObject.object_index == obj_target) {
						with (targetedObject) {
							scr_trigger_target()
						}
					}
					else if (targetedObject.object_index == obj_grenade) {
						with (targetedObject) {
							damage += other.damage
							radius *= railcannonRadiusMultiply
							scr_detonate_grenade()
						}
					}
				}
				
				instance_create_layer(x, y, layer, obj_visual_projectile, {endX : hitX, endY : hitY, width : railcannonShotWidth})
				break
			case "blaster":
				alarm[weaponAlarms.notAttacking] = attackDuration
				alarm[weaponAlarms.takeOffCooldown] = attackCooldown
				
				// recoil (blaster has none)
				// obj_player.xVelocity -= recoil * dcos(directionPointing)
				// obj_player.grav += recoil * dsin(directionPointing)
				
				instance_create_layer(x, y, layer, obj_grenade, {direction : directionPointing, speed : clamp(distance_to_point(mouse_x, mouse_y) / grenadeSpeedDivisor, grenadeSpeedMin, grenadeSpeedMax), damage : damage})
				break
		}
	}
}