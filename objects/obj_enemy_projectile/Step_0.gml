if (place_meeting(x, y, solids)) {
	instance_destroy()	
}

var _target = instance_place(x, y, targets)

if (_target != noone and _target != creator and _target.object_index != creator) {
	with (_target) {
		if (object_index == obj_player) {
			// bro got hit
		}
		else {
			hitpoints -= other.friendlyDamage
			
			scr_add_combo("friendlyFire")
		}
	}
	instance_destroy()
}