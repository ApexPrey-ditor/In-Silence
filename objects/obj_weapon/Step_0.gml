if (instance_exists(obj_player)) {
	if (!attacking) {
		directionPointing = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y)
		image_angle = directionPointing
	}
	
	x = obj_player.x + (dcos(directionPointing) * distanceFromPlayer)
	y = obj_player.y - (dsin(directionPointing) * distanceFromPlayer)
	
	if (mouse_check_button_pressed(obj_player.keybinds.shoot) and canAttack) {
		canAttack = false
		attacking = true
		
		switch weaponSelected {
			case "stabilizer":
				alarm[weaponAlarms.notAttacking] = attackDurations.stabilizer
				alarm[weaponAlarms.takeOffCooldown] = attackCooldowns.stabilizer
				
				var attackReach = 32
				distanceFromPlayer = weaponDistance.stabilizer + attackReach
				x = obj_player.x + (dcos(directionPointing) * distanceFromPlayer)
				y = obj_player.y - (dsin(directionPointing) * distanceFromPlayer)
				
				var targets = ds_list_create()
				instance_place_list(x, y, parryables, targets, false)
				
				if (ds_list_size(targets) > 0) {
					for (var i = 0; i < ds_list_size(targets); i++) {
						var targetedObject = ds_list_find_value(targets, i)
						
						if (instance_exists(targetedObject)) {
							if (object_is_ancestor(targetedObject.object_index, obj_enemy_parent)) {
								targetedObject.hitpoints -= damage.stabilizer
								obj_player.grav = recoil.stabilizer * dsin(directionPointing)
							}
							if (targetedObject.object_index == obj_destructable) {
								instance_destroy(targetedObject)
							}
							
							/* recoil for parrying solid objects
							obj_player.xVelocity -= recoil.stabilizer * dcos(directionPointing)
							obj_player.grav += recoil.stabilizer * dsin(directionPointing)*/
						}
					}
				}
				break
		}
	}
}