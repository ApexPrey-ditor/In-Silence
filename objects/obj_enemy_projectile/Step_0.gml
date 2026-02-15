var target = instance_place(x, y, targets)

if (target != noone and target != creator and target.object_index != creator) {
	with (target) {
		if (object_index == obj_player) {
			scr_hit(scr_find_angle_x_direction(other.direction))
		}
		else {
			hitpoints -= other.friendlyDamage
		}
	}
	instance_destroy()
}
if (place_meeting(x, y, solids)) {
	instance_destroy()
}