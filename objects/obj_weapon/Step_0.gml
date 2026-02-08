if (instance_exists(obj_player)) {
	if (!attacking) {
		directionPointing = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y)
		image_angle = directionPointing
		
		image_yscale = scr_find_angle_x_direction(directionPointing)
	}
	
	x = obj_player.x + (dcos(directionPointing) * distanceFromPlayer)
	y = obj_player.y - (dsin(directionPointing) * distanceFromPlayer)
	
	if (mouse_check_button_pressed(obj_player.keybinds.shoot) and canAttack) {
		canAttack = false
		attacking = true
		
		switch weaponSelected {
			case "revolver":
				alarm[weaponAlarms.notAttacking] = attackDurations.stabilizer
				alarm[weaponAlarms.takeOffCooldown] = attackCooldowns.stabilizer
				
				var hitX = x
				var hitY = y
				
				var xIncrease = dcos(directionPointing)
				var yIncrease = -dsin(directionPointing)
				
				while (!position_meeting(hitX, hitY, shootables) and
						hitX > 0 and hitX < scr_get_room_size()[coordinate.xPosition] and
						hitY > 0 and hitY < scr_get_room_size()[coordinate.yPosition]) {
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
		}
	}
}