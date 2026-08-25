if (room == rm_prison_init) {
	roomNumber += 1
	room_goto(normalRooms[irandom_range(0, array_length(normalRooms) - 1)])
}
if (room == rm_prison_normal) {
	var _nextRoom = normalRooms[irandom_range(0, array_length(normalRooms) - 1)]
	
	while (_nextRoom == previousRoom) {
		_nextRoom = normalRooms[irandom_range(0, array_length(normalRooms) - 1)]
	}
	
	roomNumber += 1
	
	if (roomNumber % 3 == 0) {
		enemyPower += enemyPowerIncrease
		
		if (instance_exists(obj_player)) {
			obj_player.hitpoints = obj_player.maxHealth
		}
	}
	room_goto(_nextRoom)
}