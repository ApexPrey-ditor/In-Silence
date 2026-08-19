x += xVelocity
xVelocity += xAcceleration

if (place_meeting(x, y, solids) or not place_meeting(x, y + 1, solids)) {
	instance_destroy()	
}

var _target = instance_place(x, y, targets)

if (_target != noone and _target != creator and _target.object_index != creator and not array_contains(nonHits, _target.id)) {
	if (object_is_ancestor(_target.object_index, obj_enemy_parent)) {
		_target.hitpoints -= friendlyDamage
		array_push(nonHits, _target)
			
		scr_add_combo("friendlyFire")
	}
	else if (_target.object_index == obj_player) {
		// bro got hit
	}
}