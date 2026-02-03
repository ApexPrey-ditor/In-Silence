if (instance_exists(obj_player)) {
	if (point_in_rectangle(obj_player.x, obj_player.y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
		obj_player.spawnPointID = entryID
		obj_player.spawnPointOffset = (obj_player.y - bbox_top) / (bbox_bottom - bbox_top)
	
		room_goto(roomGoto)
	}
}