instance_create_layer(x, y, layer, obj_visual_projectile, {colour : c_red, fadeTime : 60, width : radius, type : "circle"})

var _targets = ds_list_create()

collision_circle_list(x, y, radius, effected, false, true, _targets, false)

var _target = noone
var _distanceToObject = 0

for (var i = 0; i < ds_list_size(_targets); i++) {
	_target = ds_list_find_value(_targets, i)
	
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

instance_destroy()