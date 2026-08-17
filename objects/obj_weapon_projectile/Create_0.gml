enum grenadeAlarms {
	detonate
}

xVelocity = dcos(direction) * speed
grav = -dsin(direction) * speed

speed = 0

solids = scr_get_objects_of_tag("solid")
array_push(solids, obj_weapon_projectile)
shootables = scr_get_objects_of_tag("shootable")
effected = [obj_player, obj_enemy_parent, obj_weapon_projectile, obj_destructable, obj_target]

gravIntensity = baseIntensity
gravLimit = 35

bounceEfficiency = 0.7
blastKnockback = global.knockback.grenadeLauncher

alarm[grenadeAlarms.detonate] = detonationTime

function scr_add_speed(amount, dir) {
	xVelocity += dcos(dir) * amount
	grav -= dsin(dir) * amount
}

function scr_detonate_grenade() {
	with (obj_enemy_parent) {
		scr_test_sound_detection(other.x, other.y)
	}
	
	instance_create_layer(x, y, layer, obj_visual_projectile, {colour : c_red, fadeTime : 60, width : radius, type : "circle"})

	var _targets = ds_list_create()

	collision_circle_list(x, y, radius, effected, false, true, _targets, false)

	var _target = noone
	var _distanceToObject = 0

	for (var i = 0; i < ds_list_size(_targets); i++) {
		_target = ds_list_find_value(_targets, i)
		
		if (object_is_ancestor(_target.object_index, obj_enemy_parent)) {
			_distanceToObject = distance_to_point(_target.x, _target.y)
			direction = point_direction(x, y, _target.x, _target.y)
			
			_target.xVelocity += dcos(direction) * (radius - _distanceToObject) * (sqrt(damage) * blastKnockback)
			_target.grav -= dsin(direction) * (radius - _distanceToObject) * (sqrt(damage) * blastKnockback)
			
			_target.hitpoints -= damage
			
			scr_add_combo("baseGrenade")
		}
		else {
			switch (_target.object_index) {
				case obj_player:
					_distanceToObject = distance_to_point(_target.x, _target.y)
					direction = point_direction(x, y, _target.x, _target.y)
			
					_target.xVelocity += dcos(direction) * (radius - _distanceToObject) * (sqrt(damage) * blastKnockback)
					_target.grav -= dsin(direction) * (radius - _distanceToObject) * (sqrt(damage) * blastKnockback)
					break
				case obj_weapon_projectile:
					_distanceToObject = distance_to_point(_target.x, _target.y)
					direction = point_direction(x, y, _target.x, _target.y)
			
					_target.xVelocity += dcos(direction) * (radius - _distanceToObject) * (sqrt(damage) * blastKnockback)
					_target.grav -= dsin(direction) * (radius - _distanceToObject) * (sqrt(damage) * blastKnockback)
					break
				case obj_destructable:
					instance_destroy(_target)
					break
				case obj_target:
					with (_target) {
						scr_trigger_target()
					}
					break
			}
		}
	}

	instance_destroy()
}