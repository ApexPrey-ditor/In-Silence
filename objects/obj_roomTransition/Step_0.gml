if (place_meeting(x, y, obj_player)) {
	if (obj_player.x < scr_get_room_size()[roomSize.width] / 2) {
		obj_player.x = scr_get_room_size(roomGoto)[roomSize.width] - positionOffset
	}
	else {
		obj_player.x = positionOffset
	}
	
	obj_player.y = scr_get_room_size(roomGoto)[roomSize.height] - (scr_get_room_size()[roomSize.height] - obj_player.y)
	show_debug_message(scr_get_room_size(roomGoto)[roomSize.height] - (scr_get_room_size()[roomSize.height] - obj_player.y))
	
	room_goto(roomGoto)
}