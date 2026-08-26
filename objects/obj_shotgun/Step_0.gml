x = obj_player.x + (dcos(image_angle) * distanceFromPlayer)
y = obj_player.y - (dsin(image_angle) * distanceFromPlayer)

if (scr_input_check_pressed(obj_player.keybinds.quickShotgun) and canAttack) {
	canAttack = false
	attacking = true
	
	with (obj_enemy_parent) {
		scr_test_sound_detection(other.x, other.y)
	}
		
	image_alpha = 1

	alarm[weaponAlarms.notAttacking] = attackDuration
	alarm[weaponAlarms.takeOffCooldown] = attackCooldown
		
	image_angle = point_direction(obj_player.x, obj_player.y, mouse_x, mouse_y)
		
	x = obj_player.x + (dcos(image_angle) * distanceFromPlayer)
	y = obj_player.y - (dsin(image_angle) * distanceFromPlayer)
	
	// recoil
	obj_player.xVelocity -= recoil * dcos(image_angle)
	obj_player.grav += recoil * dsin(image_angle)
		
	var targets = ds_list_create()
	instance_place_list(x, y, parryables, targets, false)
				
	if (ds_list_size(targets) > 0) {
		for (var i = 0; i < ds_list_size(targets); i++) {
			var targetedObject = ds_list_find_value(targets, i)
						
			if (instance_exists(targetedObject)) {
				if (object_is_ancestor(targetedObject.object_index, obj_enemy_parent)) {
					targetedObject.hitpoints -= damage
					
					// knockback
					targetedObject.xVelocity += knockback * dcos(image_angle)
					targetedObject.grav -= knockback * dsin(image_angle)
					
					scr_trigger_user_event(targetedObject, enemyUserEvents.parried)
					
					global.railcannonCharge += hitChargeAmount
					scr_add_combo("baseShotgun")
				}
				else if (targetedObject.object_index == obj_destructable) {
					instance_destroy(targetedObject)
				}
				else if (targetedObject.object_index == obj_enemy_projectile) {
					targetedObject.direction += 180
					targetedObject.speed *= hitbackPower
					targetedObject.creator = obj_player
					
					targetedObject.friendlyDamage *= hitbackPower
					
					obj_init.alarm[initAlarms.unpauseAll] = baseParryFreezeFrame
					
					global.railcannonCharge += global.parryChargeAmount
					scr_add_combo("baseParry")
					scr_pause_objects(all)
				}
				else if (targetedObject.object_index == obj_grenade) {
					targetedObject.xVelocity += dcos(image_angle) * (damage * hitbackPower)
					targetedObject.grav -= dsin(image_angle) * (damage * hitbackPower)
					
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