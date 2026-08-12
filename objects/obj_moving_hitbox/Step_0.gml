if (place_meeting(x, y, obj_player)) {
	obj_player.x += x - xprevious
	obj_player.y += y - yprevious
	
	obj_player.xVelocity += x - xprevious
	obj_player.grav += y - yprevious
}