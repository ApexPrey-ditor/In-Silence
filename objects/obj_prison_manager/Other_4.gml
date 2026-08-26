if (room == rm_prison_init) {
	roomNumber += 1
	room_goto(rm_prison_upgrade)
	//room_goto(rm_prison_11)
}
if (room == rm_prison_normal) {
	var _nextRoom = normalRooms[irandom_range(0, array_length(normalRooms) - 1)]
	
	while (_nextRoom == previousRoom) {
		_nextRoom = normalRooms[irandom_range(0, array_length(normalRooms) - 1)]
	}
	
	if (previousRoom != rm_prison_upgrade) {
		roomNumber += 1
	}
	
	if (roomNumber % 3 == 0) {
		enemyPower *= enemyPowerIncrease
		enemyLevel += 1
		
		if (instance_exists(obj_player)) {
			if (roomNumber % 6 == 0) {
				room_goto(rm_prison_upgrade)
			}
		}
	}
	room_goto(_nextRoom)
}