if (instance_exists(obj_player) and (not killEnemiesRequired or not instance_exists(obj_enemy_parent))) {
	if (point_in_rectangle(obj_player.x, obj_player.y, bbox_left, bbox_top, bbox_right, bbox_bottom)) {
		obj_player.spawnPointID = entryID
		obj_player.spawnPointOffset = max(0, min((obj_player.bbox_bottom - bbox_top) / (bbox_bottom - bbox_top), 1))
	
		room_goto(roomGoto)
	}
}