if (room == rm_prison_init) {
	//room_goto(rm_prison_19)
}
if (room == rm_prison_normal) {
	var _nextRoom = normalRooms[irandom_range(0, array_length(normalRooms) - 1)]
	
	while (_nextRoom == previousRoom) {
		_nextRoom = normalRooms[irandom_range(0, array_length(normalRooms) - 1)]
	}
	
	if (previousRoom != rm_prison_upgrade and previousRoom != rm_prison_init) {
		roomNumber += 1
		
		if (roomNumber % enemyLevelUpRoom == 0) {
			enemyLevel += 1
			enemyPower = enemyPowerFunction(enemyLevel)
		}
		
		if (instance_exists(obj_player)) {
			if (roomNumber % playerLevelUpRoom == 0) {
				obj_player.hitpoints = obj_player.maxHealth
				room_goto(rm_prison_upgrade)
			}
			else {
				room_goto(_nextRoom)
			}
		}
	}
	else {
		room_goto(_nextRoom)
	}
}