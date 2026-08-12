enum movingHitboxAlarms {
	stopMovement
}

nodeOn = 0
	
nodeObjects = [instance_create_layer(x, y, layer, obj_node, {movementId : movementId, nodeNumber : 0})]
nodes = []
	
with (obj_node) {
	if (movementId == other.movementId) {
		array_push(other.nodeObjects, id)
		array_push(nodeObjects, [])
	}
}
	
for (var i = 0; i < array_length(nodeObjects); i++) {
	nodes[nodeObjects[i].nodeNumber] = nodeObjects[i]
}

// add easing later
function scr_move_to_node(time) {
	nodeOn =+ 1
	var nextNode = nodes[nodeOn]
	
	direction = point_direction(x, y, nextNode.x, nextNode.y)
	speed = point_distance(x, y, nextNode.x, nextNode.y) / time
	
	alarm[movingHitboxAlarms.stopMovement] = time
}

scr_move_to_node(300)