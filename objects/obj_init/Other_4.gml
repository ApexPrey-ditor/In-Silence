if (not array_contains(struct_get_names(removeFromRoom), room_get_name(room))) {
	struct_set(removeFromRoom, room_get_name(room), [])
}

var structKeysList = struct_get_names(removeFromRoom)
var instancesToKill = []

for (var i = 0; i < array_length(structKeysList); i++) {
	if (structKeysList[i] == room_get_name(room)) {
		instancesToKill = struct_get(removeFromRoom, room_get_name(room))
		
		for (var w = 0; w < array_length(instancesToKill); w++) {
			instance_destroy(instancesToKill[w])
		}
		break
	}
}

global.enemiesLeft = 0