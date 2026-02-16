event_inherited()

if (instance_exists(obj_player)) {
	var prebbox_top = bbox_top
	image_yscale = 2 / sprite_height
	if (place_meeting(x, prebbox_top, obj_player) and obj_player.grav > 0) {
		obj_player.grav = -bounceHeight
		obj_player.isSlamming = false
		obj_player.isDiving = false
		obj_player.canWalk = true
		instance_destroy()
		exit
	}
	image_yscale = 1
	
	if (distance_to_object(obj_player) < range) {
		if ((obj_player.x < x and xDirection == -1) or (obj_player.x >= x and xDirection == 1)) {
			spotted = true
		}
		
		if (spotted) {
			charging += 1
			doBasicWalk = false
			xVelocity = 0
			image_xscale = abs(image_xscale) * scr_find_angle_x_direction(point_direction(x, y, obj_player.x, obj_player.y))
			
			if (charging >= 120) {
				charging = 0
				
				instance_create_layer(x + sprite_width / 2, y - abs(sprite_height / 2), "Enemies", obj_enemy_projectile, {direction : point_direction(x, y, obj_player.x, obj_player.y), speed : projectileSpeed, creator : id})
			}
		}
	}
	else {
		spotted = false
		charging = 0
		doBasicWalk = true
	}
}