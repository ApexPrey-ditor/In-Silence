event_inherited()

xVelocity = topXSpeed * xDirection

if (place_meeting(x + xDirection, y, solids) or !position_meeting(x + (sprite_width / 2 * xDirection) + xDirection, bbox_bottom + stepUpHeight + 1, solids)) {
	xDirection = -xDirection
}

if (instance_exists(obj_player)) {
	var prebbox_top = bbox_top
	image_yscale = 1 / sprite_height
	if (place_meeting(x, prebbox_top, obj_player) and obj_player.grav > 0) {
		obj_player.grav = -bounceHeight
		obj_player.isSlamming = false
		obj_player.isDiving = false
		obj_player.canWalk = true
		instance_destroy()
		exit
	}
	image_yscale = 1
	image_xscale = 0.5
	if (place_meeting(x + (sprite_width / 2 * xDirection), y, obj_player)) {
		with (obj_player) {
			scr_hit(other.xDirection)
		}
	}
	image_xscale = 1
}