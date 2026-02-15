x = obj_player.x + (dcos(image_angle) * weaponDistance.stabilizer)
y = obj_player.y - (dsin(image_angle) * weaponDistance.stabilizer)

if (mouse_check_button_pressed(obj_player.keybinds.quickStabilizer) and canAttack) {
	canAttack = false
	attacking = true
		
	image_alpha = 1

	alarm[weaponAlarms.notAttacking] = attackDurations.stabilizer
	alarm[weaponAlarms.takeOffCooldown] = attackCooldowns.stabilizer
		
	image_angle = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y)
		
	x = obj_player.x + (dcos(image_angle) * weaponDistance.stabilizer)
	y = obj_player.y - (dsin(image_angle) * weaponDistance.stabilizer)
		
	var targets = ds_list_create()
	instance_place_list(x, y, parryables, targets, false)
				
	if (ds_list_size(targets) > 0) {
		for (var i = 0; i < ds_list_size(targets); i++) {
			var targetedObject = ds_list_find_value(targets, i)
						
			if (instance_exists(targetedObject)) {
				if (object_is_ancestor(targetedObject.object_index, obj_enemy_parent)) {
					targetedObject.hitpoints -= global.weaponDamage.stabilizer
					obj_player.isSlamming = false
					obj_player.isDiving = false
					obj_player.canWalk = true
				}
				else if (targetedObject.object_index == obj_destructable) {
					instance_destroy(targetedObject)
				}
				else if (targetedObject.object_index == obj_enemy_projectile) {
					targetedObject.direction += 180
					targetedObject.speed *= 3
					targetedObject.creator = obj_player
					
					obj_init.alarm[initAlarms.unpauseAll] = 15
					scr_pause_objects(all)
				}
							
				/* recoil for parrying solid objects
				obj_player.xVelocity -= recoil.stabilizer * dcos(directionPointing)
				obj_player.grav += recoil.stabilizer * dsin(directionPointing)*/
			}
		}
	}
}