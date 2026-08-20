if (place_meeting(x, y, solids)) {
	instance_destroy()	
}

var _target = instance_place(x, y, targets)

if (_target != noone and _target != creator and _target.object_index != creator) {
	if (object_is_ancestor(_target.object_index, obj_enemy_parent)) {
		_target.hitpoints -= friendlyDamage
			
		scr_add_combo("friendlyFire")
	}
	else if (_target.object_index == obj_player) {
		obj_player.scr_hit()
	}
	
	instance_destroy()
}