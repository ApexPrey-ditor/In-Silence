x = obj_player.x + (dcos(image_angle) * global.weaponDistance.shotgun)
y = obj_player.y - (dsin(image_angle) * global.weaponDistance.shotgun)

if (mouse_check_button_pressed(obj_player.keybinds.quickShotgun) and canAttack) {
	canAttack = false
	attacking = true
		
	image_alpha = 1

	alarm[weaponAlarms.notAttacking] = global.attackDurations.shotgun
	alarm[weaponAlarms.takeOffCooldown] = global.attackCooldowns.shotgun
		
	image_angle = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y)
		
	x = obj_player.x + (dcos(image_angle) * global.weaponDistance.shotgun)
	y = obj_player.y - (dsin(image_angle) * global.weaponDistance.shotgun)
	
	// recoil
	obj_player.xVelocity -= global.recoil.shotgun * dcos(image_angle)
	obj_player.grav += global.recoil.shotgun * dsin(image_angle)
		
	var targets = ds_list_create()
	instance_place_list(x, y, parryables, targets, false)
				
	if (ds_list_size(targets) > 0) {
		for (var i = 0; i < ds_list_size(targets); i++) {
			var targetedObject = ds_list_find_value(targets, i)
						
			if (instance_exists(targetedObject)) {
				if (object_is_ancestor(targetedObject.object_index, obj_enemy_parent)) {
					targetedObject.hitpoints -= global.weaponDamage.shotgun
					obj_player.isSlamming = false
					obj_player.isDiving = false
					obj_player.canWalk = true
				}
				else if (targetedObject.object_index == obj_destructable) {
					instance_destroy(targetedObject)
				}
				else if (targetedObject.object_index == obj_enemy_projectile) {
					targetedObject.direction += 180
					targetedObject.speed *= hitbackPower
					targetedObject.creator = obj_player
					
					obj_init.alarm[initAlarms.unpauseAll] = baseParryFreezeFrame
					scr_pause_objects(all)
				}
				else if (targetedObject.object_index == obj_weapon_projectile) {
					targetedObject.xVelocity += dcos(image_angle) * (global.weaponDamage.shotgun * hitbackPower)
					targetedObject.grav -= dsin(image_angle) * (global.weaponDamage.shotgun * hitbackPower)
					
					with (targetedObject) {
						detonationTime += grenadeLifespanIncrease
						alarm[grenadeAlarms.detonate] += grenadeLifespanIncrease
					}
					
					obj_init.alarm[initAlarms.unpauseAll] = baseParryFreezeFrame
					scr_pause_objects(all)
				}
			}
		}
	}
}